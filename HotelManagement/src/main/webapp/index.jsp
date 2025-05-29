<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Hotel Management System</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet"/>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      position: relative;
      overflow-x: hidden;
    }

    .background-shape {
      content: "";
      position: absolute;
      width: 300px;
      height: 300px;
      background: rgba(255, 255, 255, 0.3);
      filter: blur(90px);
      border-radius: 50%;
      z-index: 0;
      top: -50px;
      right: -100px;
    }

    .container {
      max-width: 960px;
      width: 100%;
      background: rgba(255, 255, 255, 0.9);
      backdrop-filter: blur(20px);
      border-radius: 20px;
      box-shadow: 0 15px 35px rgba(0, 0, 0, 0.08);
      overflow: hidden;
      z-index: 1;
      position: relative;
      border: 1px solid #dbeafe;
      animation: fadeInUp 1s ease;
    }

    @keyframes fadeInUp {
      from {
        opacity: 0;
        transform: translateY(20px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .header {
      background: linear-gradient(135deg, #0f172a, #1e293b);
      color: white;
      text-align: center;
      padding: 40px 24px;
    }

    .main-logo {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 12px;
      margin-bottom: 10px;
    }

    .logo-icon {
      position: relative;
      font-size: 2.5rem;
    }

    .logo-key {
      position: absolute;
      top: -6px;
      right: -6px;
      font-size: 0.9rem;
      animation: keyFloat 3s ease-in-out infinite;
    }

    @keyframes keyFloat {
      0%, 100% { transform: translateY(0); }
      50% { transform: translateY(-4px); }
    }

    .header h1 {
      font-size: 2rem;
      font-weight: 700;
      background: linear-gradient(90deg, #60a5fa, #1e40af);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }

    .header p {
      font-size: 1rem;
      color: #cbd5e1;
    }

    .content {
      padding: 36px;
    }

    .modules-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
      gap: 28px;
    }

    .module-card {
      background: #f9fafb;
      border-radius: 16px;
      padding: 24px;
      border: 1px solid #e5e7eb;
      transition: all 0.3s ease;
      position: relative;
      overflow: hidden;
    }

    .module-card:hover {
      transform: translateY(-6px);
      box-shadow: 0 12px 25px rgba(0, 0, 0, 0.1);
      border-color: #c7d2fe;
    }

    .module-header {
      display: flex;
      align-items: center;
      margin-bottom: 18px;
      padding-bottom: 12px;
      border-bottom: 1px solid #e2e8f0;
    }

    .module-icon {
      width: 50px;
      height: 50px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
      margin-right: 14px;
      position: relative;
    }

    .reservations .module-icon {
      background: #dbeafe;
      color: #1e40af;
    }

    .reports .module-icon {
      background: #dcfce7;
      color: #15803d;
    }

    .reservation-heart {
      position: absolute;
      top: -2px;
      right: -2px;
      font-size: 0.7rem;
      animation: heartbeat 2s ease-in-out infinite;
    }

    .reports-check {
      position: absolute;
      top: -3px;
      right: -3px;
      font-size: 0.6rem;
      animation: checkPulse 2.5s ease-in-out infinite;
    }

    @keyframes heartbeat {
      0%, 100% { transform: scale(1); }
      50% { transform: scale(1.1); }
    }

    @keyframes checkPulse {
      0%, 100% { opacity: 1; }
      50% { opacity: 0.5; }
    }

    .module-title {
      font-size: 1.25rem;
      font-weight: 600;
      color: #1f2937;
    }

    .action-list {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .action-btn {
      display: flex;
      align-items: center;
      padding: 12px 16px;
      background: white;
      border: 1px solid #e5e7eb;
      border-radius: 10px;
      color: #374151;
      text-decoration: none;
      font-weight: 500;
      font-size: 0.95rem;
      transition: all 0.2s ease;
    }

    .action-btn i {
      margin-right: 10px;
      font-size: 1rem;
    }

    .reservations .action-btn:hover {
      background: #eff6ff;
      border-color: #3b82f6;
      color: #1e40af;
    }

    .reports .action-btn:hover {
      background: #f0fdf4;
      border-color: #22c55e;
      color: #15803d;
    }

    .footer {
      text-align: center;
      padding: 24px;
      color: #6b7280;
      font-size: 0.85rem;
      border-top: 1px solid #e5e7eb;
      background: #f9fafb;
    }

    @media (max-width: 768px) {
      .content {
        padding: 24px;
      }

      .modules-grid {
        grid-template-columns: 1fr;
        gap: 18px;
      }
    }
  </style>
</head>
<body>
  <div class="background-shape"></div>
  <div class="container">
    <header class="header">
      <div class="main-logo">
        <div class="logo-icon">
          <i class="fas fa-concierge-bell"></i>
          <i class="fas fa-key logo-key"></i>
        </div>
      </div>
      <h1>Hotel Management System</h1>
      <p>"Smart control for seamless hotel operations"</p>
    </header>

    <div class="content">
      <div class="modules-grid">
        <!-- Reservations Module -->
        <div class="module-card reservations">
          <div class="module-header">
            <div class="module-icon">
              <i class="fas fa-door-open"></i>
              <i class="fas fa-heart reservation-heart"></i>
            </div>
            <h2 class="module-title">Reservations</h2>
          </div>
          <div class="action-list">
            <a href="reservationadd.jsp" class="action-btn"><i class="fas fa-plus"></i>Add New Reservation</a>
            <a href="reservationupdate.jsp" class="action-btn"><i class="fas fa-edit"></i>Update Reservation</a>
            <a href="reservationdelete.jsp" class="action-btn"><i class="fas fa-times"></i>Cancel Reservation</a>
            <a href="displayReservations" class="action-btn"><i class="fas fa-list"></i>View All Reservations</a>
          </div>
        </div>

        <!-- Reports Module -->
        <div class="module-card reports">
          <div class="module-header">
            <div class="module-icon">
              <i class="fas fa-clipboard-list"></i>
              <i class="fas fa-check-circle reports-check"></i>
            </div>
            <h2 class="module-title">Reports</h2>
          </div>
          <div class="action-list">
            <a href="reportCriteria" class="action-btn"><i class="fas fa-file-alt"></i>Generate Reports</a>
          </div>
        </div>
      </div>
    </div>

    <footer class="footer">
      &copy; <script>document.write(new Date().getFullYear())</script> Hotel Management System by sudeepkalapur. All rights reserved.
    </footer>
  </div>
</body>
</html>
