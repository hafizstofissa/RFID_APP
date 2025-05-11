#include <avr/io.h>
#include <util/delay.h>

// تعريفات SPI
#define SPI_DDR DDRB
#define SPI_PORT PORTB
#define SS PINB0  // Slave Select (SS) على PORTB0
#define SCK PINB1 // Serial Clock (SCK) على PORTB1
#define MOSI PINB2 // Master Out Slave In (MOSI) على PORTB2
#define MISO PINB3 // Master In Slave Out (MISO) على PORTB3

// تهيئة SPI
void SPI_Init() {
    // تعيين MOSI و SCK و SS كمخرجات
    SPI_DDR |= (1 << MOSI) | (1 << SCK) | (1 << SS);
    
    // تعيين MISO كمدخل
    SPI_DDR &= ~(1 << MISO);
    
    // تمكين SPI, وضع Master, معدل الساعة Fosc/16
    SPCR = (1 << SPE) | (1 << MSTR) | (1 << SPR0);
}

// إرسال واستقبال بايت واحد عبر SPI
unsigned char SPI_Transfer(unsigned char data) {
    SPDR = data; // إرسال البيانات
    while (!(SPSR & (1 << SPIF))); // انتظار اكتمال الإرسال
    return SPDR; // إرجاع البيانات المستلمة
}

// كتابة بيانات إلى RC522
void RC522_Write(unsigned char address, unsigned char value) {
    SPI_PORT &= ~(1 << SS); // تفعيل RC522 (SS منخفض)
    SPI_Transfer((address << 1) & 0x7E); // إرسال عنوان التسجيل
    SPI_Transfer(value); // إرسال القيمة
    SPI_PORT |= (1 << SS); // تعطيل RC522 (SS مرتفع)
}

// قراءة بيانات من RC522
unsigned char RC522_Read(unsigned char address) {
    SPI_PORT &= ~(1 << SS); // تفعيل RC522 (SS منخفض)
    SPI_Transfer(((address << 1) & 0x7E) | 0x80); // إرسال عنوان التسجيل مع وضع القراءة
    unsigned char value = SPI_Transfer(0x00); // قراءة القيمة
    SPI_PORT |= (1 << SS); // تعطيل RC522 (SS مرتفع)
    return value;
}

// تهيئة RC522
void RC522_Init() {
    RC522_Write(0x01, 0x0F); // تهيئة التسجيلات
    RC522_Write(0x2A, 0x8D); // تعيين Timer
    RC522_Write(0x2B, 0x3E); // تعيين Timer
    RC522_Write(0x2D, 30);   // تعيين Timer
    RC522_Write(0x2C, 0);    // تعيين Timer
    RC522_Write(0x15, 0x40); // تعيين TxAuto
}

// البحث عن بطاقة RFID
unsigned char RC522_Request(unsigned char reqMode, unsigned char *TagType) {
    RC522_Write(0x0D, 0x07); // إرسال أمر Request
    unsigned char status;
    unsigned int backBits;
    *TagType = reqMode;
    RC522_Write(0x09, *TagType);
    status = RC522_Read(0x05);
    if (status & 0x1F) {
        backBits = RC522_Read(0x0A);
        backBits |= (RC522_Read(0x0B) << 8);
    }
    return status;
}

// قراءة UID البطاقة
unsigned char RC522_ReadUID(unsigned char *uid) {
    unsigned char status;
    status = RC522_Request(0x26, &uid[0]); // البحث عن البطاقة
    if (status == 0x00) {
        RC522_Write(0x0D, 0x40); // إرسال أمر Anti-collision
        for (unsigned char i = 0; i < 5; i++) {
            uid[i] = RC522_Read(0x0C + i); // قراءة UID
        }
    }
    return status;
}

void main() {
    SPI_Init(); // تهيئة SPI
    RC522_Init(); // تهيئة RC522
    
    unsigned char uid[5]; // مصفوفة لتخزين UID
    
    while (1) {
        if (RC522_ReadUID(uid) == 0x00) { // إذا تم العثور على بطاقة
            // عرض UID على UART أو شاشة LCD
            for (unsigned char i = 0; i < 5; i++) {
                UART_Transmit(uid[i]); // إرسال UID عبر UART (إذا كان UART مهيأ)
            }
        }
        _delay_ms(500); // انتظار قبل البحث مرة أخرى
    }
}