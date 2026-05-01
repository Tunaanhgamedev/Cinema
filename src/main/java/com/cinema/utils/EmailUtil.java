package com.cinema.utils;

import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

public class EmailUtil {

    // Cấu hình thông tin Email gửi (Nên để trong config/env)
    private static final String FROM_EMAIL = "bobixi.cinema@gmail.com";
    private static final String APP_PASSWORD = "your-app-password-here"; // Mật khẩu ứng dụng Gmail

    public static void sendEmail(String toEmail, String subject, String bodyHtml) {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "BOBIXI Cinema"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject);
            
            // Nội dung HTML
            MimeBodyPart mimeBodyPart = new MimeBodyPart();
            mimeBodyPart.setContent(bodyHtml, "text/html; charset=utf-8");

            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(mimeBodyPart);

            message.setContent(multipart);

            // Gửi email trong luồng riêng để không chặn request của người dùng
            new Thread(() -> {
                try {
                    Transport.send(message);
                    System.out.println("Email sent successfully to: " + toEmail);
                } catch (MessagingException e) {
                    System.err.println("Failed to send email to " + toEmail + ": " + e.getMessage());
                }
            }).start();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getBookingConfirmationTemplate(String userName, String movieTitle, String seats, String time, String total) {
        return """
            <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 10px;">
                <div style="text-align: center; margin-bottom: 20px;">
                    <h1 style="color: #6366f1; margin: 0;">BOBIXI CINEMA</h1>
                    <p style="color: #666;">Cảm ơn bạn đã đặt vé tại rạp chúng tôi!</p>
                </div>
                
                <div style="background-color: #f8fafc; padding: 20px; border-radius: 8px; margin-bottom: 20px;">
                    <h2 style="font-size: 18px; color: #1e293b; margin-top: 0;">Xác nhận đặt vé thành công</h2>
                    <p>Chào <strong>%s</strong>,</p>
                    <p>Đơn hàng của bạn đã được thanh toán thành công. Dưới đây là thông tin vé của bạn:</p>
                    
                    <table style="width: 100%%; border-collapse: collapse; margin-top: 15px;">
                        <tr>
                            <td style="padding: 8px 0; color: #64748b;">Phim:</td>
                            <td style="padding: 8px 0; font-weight: bold; text-align: right;">%s</td>
                        </tr>
                        <tr>
                            <td style="padding: 8px 0; color: #64748b;">Ghế:</td>
                            <td style="padding: 8px 0; font-weight: bold; text-align: right;">%s</td>
                        </tr>
                        <tr>
                            <td style="padding: 8px 0; color: #64748b;">Suất chiếu:</td>
                            <td style="padding: 8px 0; font-weight: bold; text-align: right;">%s</td>
                        </tr>
                        <tr style="border-top: 2px solid #e2e8f0;">
                            <td style="padding: 15px 0; color: #1e293b; font-weight: bold;">TỔNG TIỀN:</td>
                            <td style="padding: 15px 0; color: #6366f1; font-weight: bold; font-size: 20px; text-align: right;">%s đ</td>
                        </tr>
                    </table>
                </div>
                
                <div style="text-align: center; color: #94a3b8; font-size: 12px;">
                    <p>Đây là email tự động, vui lòng không trả lời email này.</p>
                    <p>&copy; 2026 BOBIXI Cinema. All rights reserved.</p>
                </div>
            </div>
        """.formatted(userName, movieTitle, seats, time, total);
    }
}
