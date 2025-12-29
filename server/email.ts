import sgMail from "@sendgrid/mail";

/* ===================== INITIAL SETUP ===================== */

if (!process.env.SENDGRID_API_KEY) {
    console.warn("SENDGRID_API_KEY is missing. Emails will not be sent.");
} else {
    sgMail.setApiKey(process.env.SENDGRID_API_KEY);
}

const FROM_EMAIL = process.env.FROM_EMAIL || "no-reply@geniesugar.com";
const APP_URL = process.env.APP_URL || "http://localhost:5000";

/* ===================== HELPERS ===================== */

function roleLabel(role: string) {
    if (role === "physician") return "Physician";
    if (role === "dietitian") return "Dietitian";
    return "Patient";
}

/* ===================== WELCOME EMAIL ===================== */

export async function sendWelcomeEmail(
    toEmail: string,
    fullName: string,
    role: string
) {
    await sgMail.send({
        to: toEmail,
        from: {
            email: FROM_EMAIL,
            name: "GenieSugar",
        },
        subject: "Welcome to GenieSugar 💙",
        html: `
<!DOCTYPE html>
<html>
  <body style="margin:0;padding:0;background-color:#f4f6f8;font-family:Arial,Helvetica,sans-serif;">
    <table width="100%" cellpadding="0" cellspacing="0">
      <tr>
        <td align="center" style="padding:40px 0;">
          <table width="600" cellpadding="0" cellspacing="0" style="background:#ffffff;border-radius:10px;box-shadow:0 4px 12px rgba(0,0,0,0.08);">
            
            <!-- LOGO -->
            <tr>
              <td align="center" style="padding:30px;">
                <img 
                  src="https://via.placeholder.com/180x60?text=GenieSugar" 
                  alt="GenieSugar Logo"
                  style="max-width:180px;"
                />
              </td>
            </tr>

            <!-- TITLE -->
            <tr>
              <td style="padding:0 40px;">
                <h2 style="color:#1f2937;">Welcome to GenieSugar, ${fullName} 👋</h2>
              </td>
            </tr>

            <!-- CONTENT -->
            <tr>
              <td style="padding:0 40px 20px 40px;color:#4b5563;font-size:15px;line-height:1.6;">
                <p>
                  We're excited to welcome you to <strong>GenieSugar</strong> — a diabetes management platform designed to help patients and healthcare providers track glucose, food, and health insights easily.
                </p>

                <p>
                  You registered as a <strong>${roleLabel(role)}</strong>.
                </p>

                <p>
                  Click the button below to log in and get started:
                </p>
              </td>
            </tr>

            <!-- BUTTON -->
            <tr>
              <td align="center" style="padding:20px;">
                <a 
                  href="${APP_URL}/login"
                  style="
                    background:#2563eb;
                    color:#ffffff;
                    text-decoration:none;
                    padding:14px 28px;
                    border-radius:6px;
                    font-weight:bold;
                    display:inline-block;
                  "
                >
                  Log in to GenieSugar
                </a>
              </td>
            </tr>

            <!-- FOOTER -->
            <tr>
              <td style="padding:30px 40px;color:#9ca3af;font-size:12px;border-top:1px solid #e5e7eb;">
                <p style="margin:0;">
                  Educational project – Student ID: 202200033<br/>
                  Bahrain Polytechnic
                </p>
              </td>
            </tr>

          </table>
        </td>
      </tr>
    </table>
  </body>
</html>
    `,
    });
}


/* ===================== EMAIL VERIFICATION ===================== */

export async function sendVerificationEmail(
    toEmail: string,
    fullName: string,
    verificationToken: string
) {
    const url = `${APP_URL}/api/verify-email/${verificationToken}`;

    await sgMail.send({
        to: toEmail,
        from: FROM_EMAIL,
        subject: "Verify your GenieSugar email",
        html: `
      <p>Hello ${fullName},</p>
      <p>Please verify your email address:</p>
      <a href="${url}">Verify Email</a>
    `,
    });
}

/* ===================== GLUCOSE ALERT ===================== */

export async function sendGlucoseAlertEmail(
    toEmail: string,
    fullName: string,
    glucoseValue: number,
    alertType: "high" | "low",
    timestamp: Date
) {
    const title = alertType === "high" ? "High Glucose Alert" : "Low Glucose Alert";

    await sgMail.send({
        to: toEmail,
        from: FROM_EMAIL,
        subject: `GenieSugar Alert: ${glucoseValue} mg/dL`,
        html: `
      <h2>${title}</h2>
      <p>Dear ${fullName},</p>
      <p>Your glucose reading is <strong>${glucoseValue} mg/dL</strong>.</p>
      <p>Recorded at: ${timestamp.toLocaleString()}</p>
    `,
    });
}

/* ===================== FAMILY ALERT ===================== */

export async function sendFamilyAlertEmail(
    toEmail: string,
    familyMemberName: string,
    patientName: string,
    glucoseValue: number,
    alertType: "high" | "low"
) {
    await sgMail.send({
        to: toEmail,
        from: FROM_EMAIL,
        subject: `Family Alert: ${patientName}`,
        html: `
      <p>Dear ${familyMemberName},</p>
      <p>${patientName} recorded a ${alertType} glucose value:</p>
      <h2>${glucoseValue} mg/dL</h2>
    `,
    });
}

/* ===================== APPOINTMENT BOOKED ===================== */

export async function sendAppointmentBookedEmail(
    toEmail: string,
    patientName: string,
    physicianName: string,
    appointmentDate: Date,
    duration: number,
    notes?: string,
    requirements?: string
) {
    await sgMail.send({
        to: toEmail,
        from: FROM_EMAIL,
        subject: `Appointment with Dr. ${physicianName}`,
        html: `
      <p>Hello ${patientName},</p>
      <p>Your appointment with <strong>Dr. ${physicianName}</strong> is confirmed.</p>
      <p>${appointmentDate.toLocaleString()} (${duration} minutes)</p>
      ${notes ? `<p><strong>Notes:</strong> ${notes}</p>` : ""}
      ${requirements ? `<p><strong>Prepare:</strong> ${requirements}</p>` : ""}
    `,
    });
}

/* ===================== APPOINTMENT REMINDER ===================== */

export async function sendAppointmentReminderEmail(
    toEmail: string,
    patientName: string,
    physicianName: string,
    appointmentDate: Date,
    daysUntil: number,
    requirements?: string
) {
    await sgMail.send({
        to: toEmail,
        from: FROM_EMAIL,
        subject: `Reminder: Appointment in ${daysUntil} day(s)`,
        html: `
      <p>Hello ${patientName},</p>
      <p>You have an appointment with <strong>Dr. ${physicianName}</strong>.</p>
      <p>Date: ${appointmentDate.toLocaleString()}</p>
      ${requirements ? `<p>${requirements}</p>` : ""}
    `,
    });
}

/* ===================== PASSWORD RESET ===================== */

export async function sendPasswordResetEmail(
    toEmail: string,
    fullName: string,
    resetToken: string
) {
    const url = `${APP_URL}/reset-password/${resetToken}`;

    await sgMail.send({
        to: toEmail,
        from: FROM_EMAIL,
        subject: "Reset your GenieSugar password",
        html: `
      <p>Hello ${fullName},</p>
      <p>Click below to reset your password:</p>
      <a href="${url}">Reset Password</a>
    `,
    });
}
