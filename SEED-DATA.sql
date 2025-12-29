

INSERT INTO users (id, email, password, full_name, role, phone, diabetes_type, is_verified, email_verified) VALUES
-- Admin
('ADMIN001', 'admin@geniesugar.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'System Administrator', 'admin', '+973-1700-0001', NULL, true, true),

-- Physicians
('D001', 'ahmed.alnoor@geniesugar.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Dr. Ahmed Al-Noor', 'physician', '+973-1700-1001', NULL, true, true),
('D002', 'fatima.haddad@geniesugar.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Dr. Fatima Al-Haddad', 'physician', '+973-1700-1002', NULL, true, true),
('D003', 'khalid.mahroos@geniesugar.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Dr. Khalid Al-Mahroos', 'physician', '+973-1700-1003', NULL, true, true),

-- Dietitians
('DT001', 'sara.khalifa@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Sara Al-Khalifa', 'dietitian', '+973-1700-2001', NULL, true, true),
('DT002', 'huda.sayed@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Huda Al-Sayed', 'dietitian', '+973-1700-2002', NULL, true, true),

-- Patients
('P006', 'hussain.ali@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Hussain Ali', 'patient', '+973-3900-0006', 'type2', true, true),
('P007', 'noora.salman@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Noora Salman', 'patient', '+973-3900-0007', 'type1', true, true),
('P008', 'abdulrahman.yusuf@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Abdulrahman Yusuf', 'patient', '+973-3900-0008', 'type2', true, true),
('P009', 'maryam.jasim@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Maryam Jasim', 'patient', '+973-3900-0009', 'gestational', true, true),
('P010', 'saeed.ahmed@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Saeed Ahmed', 'patient', '+973-3900-0010', 'type2', true, true)
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- GLUCOSE READINGS (Last 7 days for P006)
-- ============================================

INSERT INTO glucose_readings (id, user_id, value, timestamp, note) VALUES
('gr001', 'P006', 95, NOW() - INTERVAL '6 days', 'Morning fasting'),
('gr002', 'P006', 142, NOW() - INTERVAL '6 days' + INTERVAL '3 hours', 'After breakfast'),
('gr003', 'P006', 88, NOW() - INTERVAL '5 days', 'Morning fasting'),
('gr004', 'P006', 156, NOW() - INTERVAL '5 days' + INTERVAL '4 hours', 'After lunch'),
('gr005', 'P006', 102, NOW() - INTERVAL '4 days', 'Morning fasting'),
('gr006', 'P006', 138, NOW() - INTERVAL '4 days' + INTERVAL '6 hours', 'After dinner'),
('gr007', 'P006', 91, NOW() - INTERVAL '3 days', 'Morning fasting'),
('gr008', 'P006', 165, NOW() - INTERVAL '3 days' + INTERVAL '3 hours', 'After breakfast'),
('gr009', 'P006', 98, NOW() - INTERVAL '2 days', 'Morning fasting'),
('gr010', 'P006', 148, NOW() - INTERVAL '2 days' + INTERVAL '4 hours', 'After lunch'),
('gr011', 'P006', 85, NOW() - INTERVAL '1 day', 'Morning fasting'),
('gr012', 'P006', 152, NOW() - INTERVAL '1 day' + INTERVAL '6 hours', 'After dinner'),
('gr013', 'P006', 92, NOW(), 'Today morning fasting'),
('gr014', 'P006', 145, NOW() + INTERVAL '3 hours', 'After breakfast'),

-- More readings for P007
('gr015', 'P007', 110, NOW() - INTERVAL '5 days', 'Morning reading'),
('gr016', 'P007', 125, NOW() - INTERVAL '4 days', 'Before lunch'),
('gr017', 'P007', 180, NOW() - INTERVAL '3 days', 'After dinner - high'),
('gr018', 'P007', 95, NOW() - INTERVAL '2 days', 'Fasting'),
('gr019', 'P007', 140, NOW() - INTERVAL '1 day', 'After breakfast')
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- CARE TEAM CONNECTIONS
-- ============================================

INSERT INTO care_team (id, patient_id, provider_id, permissions, status) VALUES
('ct001', 'P006', 'D001', 'all', 'approved'),
('ct002', 'P006', 'DT001', 'all', 'approved'),
('ct003', 'P007', 'D001', 'glucose_only', 'approved'),
('ct004', 'P007', 'D002', 'all', 'approved'),
('ct005', 'P008', 'D001', 'all', 'approved'),
('ct006', 'P008', 'DT001', 'all', 'approved'),
('ct007', 'P009', 'D002', 'all', 'approved'),
('ct008', 'P010', 'D003', 'all', 'pending')
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- CHAT MESSAGES
-- ============================================

INSERT INTO chat_messages (id, sender_id, receiver_id, content, timestamp, is_read) VALUES
('msg001', 'P006', 'D001', 'Hello Dr. Ahmed, I have a question about my glucose levels.', NOW() - INTERVAL '2 days', true),
('msg002', 'D001', 'P006', 'Hello Hussain, I see your readings. What is your concern?', NOW() - INTERVAL '2 days' + INTERVAL '1 hour', true),
('msg003', 'P006', 'D001', 'My levels after meals seem high. Should I adjust my medication?', NOW() - INTERVAL '2 days' + INTERVAL '2 hours', true),
('msg004', 'D001', 'P006', 'Your post-meal readings are slightly elevated. Let us discuss in your next appointment.', NOW() - INTERVAL '2 days' + INTERVAL '3 hours', true),
('msg005', 'P006', 'DT001', 'Hi Sara, can you suggest some low GI foods for breakfast?', NOW() - INTERVAL '1 day', true),
('msg006', 'DT001', 'P006', 'Hello Hussain! I recommend Balaleet with less sugar, or eggs with whole wheat bread.', NOW() - INTERVAL '1 day' + INTERVAL '30 minutes', false)
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- APPOINTMENTS
-- ============================================

INSERT INTO appointments (id, patient_id, provider_id, date, time, type, status, notes) VALUES
('apt001', 'P006', 'D001', CURRENT_DATE + INTERVAL '3 days', '10:00', 'checkup', 'scheduled', 'Regular glucose review'),
('apt002', 'P006', 'DT001', CURRENT_DATE + INTERVAL '5 days', '14:00', 'nutrition', 'scheduled', 'Diet planning session'),
('apt003', 'P007', 'D001', CURRENT_DATE + INTERVAL '2 days', '11:00', 'checkup', 'scheduled', 'Follow-up appointment'),
('apt004', 'P008', 'D001', CURRENT_DATE - INTERVAL '1 day', '09:00', 'checkup', 'completed', 'Routine checkup completed')
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- FAMILY CONTACTS (Emergency contacts for P006)
-- ============================================

INSERT INTO family_contacts (id, patient_id, name, relationship, phone, email, receive_alerts) VALUES
('fc001', 'P006', 'Fatima Ali', 'wife', '+973-3900-1001', 'fatima.ali@example.com', true),
('fc002', 'P006', 'Ahmed Ali', 'son', '+973-3900-1002', 'ahmed.ali@example.com', true),
('fc003', 'P007', 'Salman Hassan', 'father', '+973-3900-2001', 'salman.hassan@example.com', true)
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- ALERT SETTINGS
-- ============================================

INSERT INTO alert_settings (id, user_id, low_threshold, high_threshold, email_alerts_enabled) VALUES
('as001', 'P006', 70, 180, true),
('as002', 'P007', 70, 160, true),
('as003', 'P008', 65, 180, false)
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- ACTIVITY LOGS
-- ============================================

INSERT INTO activity_logs (id, user_id, activity_type, duration, intensity, timestamp, notes) VALUES
('al001', 'P006', 'walking', 30, 'moderate', NOW() - INTERVAL '2 days', 'Morning walk'),
('al002', 'P006', 'swimming', 45, 'moderate', NOW() - INTERVAL '4 days', 'Pool exercise'),
('al003', 'P006', 'walking', 20, 'light', NOW() - INTERVAL '1 day', 'Evening stroll'),
('al004', 'P007', 'cycling', 30, 'vigorous', NOW() - INTERVAL '3 days', 'Bike ride'),
('al005', 'P007', 'yoga', 60, 'light', NOW() - INTERVAL '1 day', 'Morning yoga session')
ON CONFLICT (id) DO NOTHING;

-- ============================================
-- PROVIDER NOTES
-- ============================================

INSERT INTO provider_notes (id, provider_id, patient_id, note, note_type, timestamp) VALUES
('pn001', 'D001', 'P006', 'Patient showing good progress with glucose management. Continue current medication.', 'clinical', NOW() - INTERVAL '7 days'),
('pn002', 'DT001', 'P006', 'Recommended reducing rice portions and increasing vegetable intake.', 'nutrition', NOW() - INTERVAL '5 days'),
('pn003', 'D001', 'P007', 'Discussed insulin adjustment for better post-meal control.', 'clinical', NOW() - INTERVAL '3 days')
ON CONFLICT (id) DO NOTHING;

-- ================================================================================
-- END OF SEED DATA
-- ================================================================================
