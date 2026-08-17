using System.Net;
using System.Net.Mail;

namespace LuanVanTotNghiep.Services;

public class EmailService(IConfiguration configuration)
{
    public async Task SendOtpEmailAsync(string toEmail, string otp)
    {
        var fromName = configuration["Smtp:FromName"] ?? "Hệ Thống Quản Lý Nhân Viên";
        var fromAddress = GetFromAddress();
        using var client = CreateSmtpClient();

        using var mail = new MailMessage
        {
            From = new MailAddress(fromAddress, fromName),
            Subject = "Mã Xác Nhận Đặt Lại Mật Khẩu",
            Body = $"Mã OTP Của Bạn Là : {otp}\nMã có hiệu lực trong 5 phút.",
            IsBodyHtml = false
        };

        mail.To.Add(toEmail);
        await client.SendMailAsync(mail);
    }

    public async Task SendInitialPasswordEmailAsync(
        string toEmail,
        string? fullName,
        string initialPassword)
    {
        var fromName = configuration["Smtp:FromName"] ?? "Hệ Thống Quản Lý Nhân Viên";
        var fromAddress = GetFromAddress();
        using var client = CreateSmtpClient();

        using var mail = new MailMessage
        {
            From = new MailAddress(fromAddress, fromName),
            Subject = "Tài khoản nhân viên đã được tạo",
            Body =
                $"Xin chào {fullName ?? "bạn"},\n\n" +
                "Tài khoản nhân viên của bạn đã được tạo.\n" +
                $"Tên đăng nhập: {toEmail}\n" +
                $"Mật khẩu ban đầu: {initialPassword}\n\n" +
                "Vui lòng đăng nhập và đổi mật khẩu để bảo vệ tài khoản.",
            IsBodyHtml = false
        };

        mail.To.Add(toEmail);
        await client.SendMailAsync(mail);
    }

    public async Task SendSchedulePublishedEmailAsync(
        string toEmail,
        string? fullName,
        string branchName,
        DateOnly startDate,
        DateOnly endDate)
    {
        var fromName = configuration["Smtp:FromName"]
            ?? "Hệ Thống Quản Lý Nhân Viên";
        var fromAddress = GetFromAddress();
        using var client = CreateSmtpClient();

        using var mail = new MailMessage
        {
            From = new MailAddress(fromAddress, fromName),
            Subject = $"Lịch làm việc mới tại {branchName}",
            Body =
                $"Xin chào {fullName ?? "bạn"},\n\n" +
                $"Lịch làm việc tại {branchName} cho tuần " +
                $"từ {startDate:dd/MM/yyyy} đến {endDate:dd/MM/yyyy} " +
                "đã được công bố.\n\n" +
                "Vui lòng đăng nhập vào hệ thống để xem ca làm cụ thể của bạn.",
            IsBodyHtml = false
        };

        mail.To.Add(toEmail);
        await client.SendMailAsync(mail);
    }

    private string GetFromAddress()
    {
        // Smtp:From là địa chỉ sender đã verify trên Brevo (dùng để hiển thị From).
        // Nếu chưa set Smtp:From, fallback về Smtp:User (giữ tương thích ngược với Gmail cũ).
        return configuration["Smtp:From"] ?? configuration["Smtp:User"] ?? string.Empty;
    }

    private SmtpClient CreateSmtpClient()
    {
        var smtpHost = configuration["Smtp:Host"];
        var smtpPort = int.Parse(configuration["Smtp:Port"] ?? "587");
        var smtpUser = configuration["Smtp:User"];
        var smtpPass = configuration["Smtp:Password"];

        if (string.IsNullOrWhiteSpace(smtpHost) ||
            string.IsNullOrWhiteSpace(smtpUser) ||
            string.IsNullOrWhiteSpace(smtpPass))
        {
            throw new InvalidOperationException(
                "Missing SMTP configuration. Please set Smtp:Host, Smtp:User, and Smtp:Password.");
        }

        return new SmtpClient(smtpHost, smtpPort)
        {
            Credentials = new NetworkCredential(smtpUser, smtpPass),
            EnableSsl = true
        };
    }
}