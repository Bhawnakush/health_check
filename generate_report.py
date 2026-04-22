import os
from datetime import datetime

REPORT_DIR = "reports"
OUTPUT_FILE = os.path.join(REPORT_DIR, "final_report.html")
report_files = [
        "disk_check.txt",
        "memory_check.txt",
        "services_check.txt",
        "log_analysis.txt",
        "cleanup.txt",
    ]
def read_file(filename):
        path = os.path.join(REPORT_DIR, filename)
        if os.path.exists(path):
            with open(path) as f:
                return f.read()
        return "No data found."

sections = ""
for fname in report_files:
        title = fname.replace("_", " ").replace(".txt", "").title()
        content = read_file(fname)
        color = "#ffe0e0" if "WARNING" in content or "NOT running" in content else "#e0ffe0"
        sections += f"""
        <div style="background:{color}; padding:15px; margin:10px 0; border-radius:6px;">
            <h2>{title}</h2>
            <pre>{content}</pre>
        </div>
        """
html = f"""<!DOCTYPE html>
    <html>
    <head><title>Health Check Report</title></head>
    <body style="font-family:monospace; padding:20px;">
        <h1>Server Health Check Report</h1>
        <p>Generated: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}</p>
        {sections}
    </body>
    </html>"""

os.makedirs(REPORT_DIR, exist_ok=True)
with open(OUTPUT_FILE, "w") as f:
        f.write(html)

print(f"Report saved to {OUTPUT_FILE}")