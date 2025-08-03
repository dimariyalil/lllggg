from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List, Optional
from datetime import datetime
import os
from dotenv import load_dotenv

load_dotenv()

app = FastAPI(title="LILCOPILGIT API")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000", "http://localhost:5173"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class DashboardMetric(BaseModel):
    name: str
    value: str
    change: str
    trend: str

class CeoTask(BaseModel):
    id: int
    phase: str
    title: str
    progress: int
    status: str
    subtasks: List[dict]

class ChatMessage(BaseModel):
    role: str
    content: str

@app.get("/")
def read_root():
    return {"message": "LILCOPILGIT API is running"}

@app.get("/api/health")
def health_check():
    return {"status": "healthy", "timestamp": datetime.now()}

@app.get("/api/dashboard/metrics")
def get_dashboard_metrics() -> List[DashboardMetric]:
    return [
        DashboardMetric(name="Revenue", value="$125,430", change="+12%", trend="up"),
        DashboardMetric(name="Active Users", value="8,234", change="+5%", trend="up"),
        DashboardMetric(name="Burn Rate", value="-$45,000", change="-8%", trend="down"),
    ]

@app.get("/api/tasks/ceo")
def get_ceo_tasks() -> List[CeoTask]:
    return [
        CeoTask(
            id=1,
            phase="Emergency",
            title="Stop the Bleeding",
            progress=40,
            status="in-progress",
            subtasks=[
                {"title": "Analyze expenses", "done": True},
                {"title": "Cut ineffective channels", "done": True},
                {"title": "Optimize infrastructure", "done": False},
            ]
        ),
        CeoTask(
            id=2,
            phase="Emergency",
            title="Data Audit",
            progress=100,
            status="completed",
            subtasks=[
                {"title": "Collect all data sources", "done": True},
                {"title": "Structure data", "done": True},
                {"title": "Validate quality", "done": True},
            ]
        ),
    ]

@app.post("/api/ai/chat")
async def chat_with_ai(message: ChatMessage):
    return {
        "role": "assistant",
        "content": f"I received your message: '{message.content}'. Claude integration coming soon!"
    }

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
