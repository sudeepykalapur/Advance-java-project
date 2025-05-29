<%-- WebContent/reports.jsp --%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
    body {
        font-family: 'Inter', sans-serif;
        background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
        min-height: 100vh;
        padding: 20px;
    }

    .container {
        max-width: 800px;
        width: 100%;
        margin: 0 auto;
        background: white;
        border-radius: 1rem;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
        border: 1px solid #e2e8f0;
        padding: 32px;
    }

    .card {
        background-color: #f9fafb; /* light gray for soft card look */
        border-radius: 0.75rem;
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
        border: 1px solid #e5e7eb;
        padding: 24px;
    }

    .btn {
        display: inline-block;
        padding: 0.75rem 1.5rem;
        border-radius: 0.5rem;
        font-weight: 600;
        text-align: center;
        transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .btn-primary {
        background-color: #3b82f6; /* blue-500 */
        color: #ffffff;
    }

    .btn-primary:hover {
        background-color: #2563eb; /* blue-600 */
        transform: translateY(-2px);
    }

    .btn-secondary {
        background-color: #94a3b8; /* slate-400 */
        color: #ffffff;
    }

    .btn-secondary:hover {
        background-color: #64748b; /* slate-500 */
        transform: translateY(-2px);
    }
</style>

</head>
<body class="flex items-center justify-center min-h-screen">
    <div class="container mx-auto p-4 md:p-8">
        <div class="card p-6 md:p-10">
            <h1 class="text-2xl md:text-3xl font-bold text-center text-purple-700 mb-8">Hotel Reports</h1>

            <p class="text-lg text-gray-700 text-center mb-8">
                Select a report type to view detailed insights into your hotel's performance.
            </p>

            <div class="flex flex-col items-center space-y-6">
                <a href="reportCriteria" class="btn btn-primary w-full max-w-sm">Generate New Report</a>
                <a href="index.jsp" class="btn btn-secondary w-full max-w-sm">Back to Home</a>
            </div>

            <p class="text-center text-gray-500 text-sm mt-10">
                You will be redirected to a form to select specific criteria for your report.
            </p>
        </div>
    </div>
</body>
</html>
