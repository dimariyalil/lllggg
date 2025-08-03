#!/bin/bash
echo "🚀 Creating LILCOPILGIT project..."

# Create all directories
mkdir -p frontend/{src/{components,pages,services,utils,store,hooks},public} backend/{api,models,services,utils} docs .github/workflows

# Create package.json
cat > frontend/package.json << 'EOF'
{
  "name": "lilcopilgit-frontend",
  "version": "1.0.0",
  "private": true,
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "tsc && vite build",
    "preview": "vite preview"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.22.0",
    "axios": "^1.6.7",
    "@reduxjs/toolkit": "^2.2.1",
    "react-redux": "^9.1.0",
    "recharts": "^2.12.0",
    "lucide-react": "^0.344.0",
    "clsx": "^2.1.0",
    "date-fns": "^3.3.1"
  },
  "devDependencies": {
    "@types/react": "^18.2.56",
    "@types/react-dom": "^18.2.19",
    "@vitejs/plugin-react": "^4.2.1",
    "autoprefixer": "^10.4.17",
    "postcss": "^8.4.35",
    "tailwindcss": "^3.4.1",
    "typescript": "^5.3.3",
    "vite": "^5.1.0"
  }
}
EOF

# Create all config files
cat > frontend/vite.config.ts << 'EOF'
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    port: 3000,
  },
})
EOF

cat > frontend/tsconfig.json << 'EOF'
{
  "compilerOptions": {
    "target": "ES2020",
    "useDefineForClassFields": true,
    "lib": ["ES2020", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "skipLibCheck": true,
    "moduleResolution": "bundler",
    "allowImportingTsExtensions": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true,
    "jsx": "react-jsx",
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noFallthroughCasesInSwitch": true,
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  },
  "include": ["src"],
  "references": [{ "path": "./tsconfig.node.json" }]
}
EOF

cat > frontend/tsconfig.node.json << 'EOF'
{
  "compilerOptions": {
    "composite": true,
    "skipLibCheck": true,
    "module": "ESNext",
    "moduleResolution": "bundler",
    "allowSyntheticDefaultImports": true
  },
  "include": ["vite.config.ts"]
}
EOF

cat > frontend/tailwind.config.js << 'EOF'
export default {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  darkMode: 'class',
  theme: {
    extend: {
      colors: {
        primary: {
          50: '#f0f9ff',
          500: '#3b82f6',
          600: '#2563eb',
          700: '#1d4ed8',
          900: '#1e3a8a',
        },
        dark: {
          bg: '#0f172a',
          card: '#1e293b',
          border: '#334155',
        }
      },
    },
  },
  plugins: [],
}
EOF

cat > frontend/postcss.config.js << 'EOF'
export default {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

cat > frontend/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en" class="dark">
  <head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/vite.svg" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>LILCOPILGIT - AI-Powered iGaming Management</title>
  </head>
  <body>
    <div id="root"></div>
    <script type="module" src="/src/main.tsx"></script>
  </body>
</html>
EOF

# Create all source files
cat > frontend/src/main.tsx << 'EOF'
import React from 'react'
import ReactDOM from 'react-dom/client'
import { BrowserRouter } from 'react-router-dom'
import { Provider } from 'react-redux'
import App from './App'
import { store } from './store'
import './index.css'

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <Provider store={store}>
      <BrowserRouter>
        <App />
      </BrowserRouter>
    </Provider>
  </React.StrictMode>,
)
EOF

cat > frontend/src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  body {
    @apply bg-dark-bg text-white;
  }
}

@layer components {
  .card {
    @apply bg-dark-card border border-dark-border rounded-lg p-6;
  }
  
  .btn-primary {
    @apply bg-primary-600 hover:bg-primary-700 text-white px-4 py-2 rounded-lg transition-colors;
  }
  
  .metric-card {
    @apply card hover:border-primary-600 transition-colors cursor-pointer;
  }
}
EOF

cat > frontend/src/App.tsx << 'EOF'
import React from 'react'
import { Routes, Route } from 'react-router-dom'
import Layout from './components/Layout'
import Dashboard from './pages/Dashboard'
import CeoTasks from './pages/CeoTasks'
import TgAnalytics from './pages/TgAnalytics'
import AiChat from './pages/AiChat'

function App() {
  return (
    <Routes>
      <Route path="/" element={<Layout />}>
        <Route index element={<Dashboard />} />
        <Route path="dashboard" element={<Dashboard />} />
        <Route path="ceo-tasks" element={<CeoTasks />} />
        <Route path="tg-analytics" element={<TgAnalytics />} />
        <Route path="ai-chat" element={<AiChat />} />
      </Route>
    </Routes>
  )
}

export default App
EOF

cat > frontend/src/store/index.ts << 'EOF'
import { configureStore } from '@reduxjs/toolkit'

export const store = configureStore({
  reducer: {},
})

export type RootState = ReturnType<typeof store.getState>
export type AppDispatch = typeof store.dispatch
EOF

cat > frontend/src/components/Layout.tsx << 'EOF'
import React from 'react'
import { Outlet, Link, useLocation } from 'react-router-dom'
import { LayoutDashboard, CheckSquare, BarChart3, MessageSquare, Menu, X } from 'lucide-react'

const navigation = [
  { name: 'Dashboard', href: '/', icon: LayoutDashboard },
  { name: 'CEO Tasks', href: '/ceo-tasks', icon: CheckSquare },
  { name: 'TG Analytics', href: '/tg-analytics', icon: BarChart3 },
  { name: 'AI Chat', href: '/ai-chat', icon: MessageSquare },
]

export default function Layout() {
  const location = useLocation()
  const [sidebarOpen, setSidebarOpen] = React.useState(false)

  return (
    <div className="flex h-screen bg-dark-bg">
      <div className={`${sidebarOpen ? 'block' : 'hidden'} md:block md:w-64 bg-dark-card border-r border-dark-border`}>
        <div className="p-4">
          <h1 className="text-2xl font-bold text-primary-500">LILCOPILGIT</h1>
          <p className="text-sm text-gray-400 mt-1">AI-Powered Management</p>
        </div>
        <nav className="mt-8">
          {navigation.map((item) => {
            const isActive = location.pathname === item.href
            return (
              <Link
                key={item.name}
                to={item.href}
                className={`flex items-center px-4 py-3 text-sm font-medium transition-colors ${
                  isActive
                    ? 'bg-primary-900/20 text-primary-500 border-r-2 border-primary-500'
                    : 'text-gray-300 hover:bg-dark-border/50 hover:text-white'
                }`}
              >
                <item.icon className="mr-3 h-5 w-5" />
                {item.name}
              </Link>
            )
          })}
        </nav>
      </div>

      <div className="flex-1 flex flex-col overflow-hidden">
        <div className="md:hidden bg-dark-card border-b border-dark-border p-4 flex justify-between items-center">
          <h1 className="text-xl font-bold text-primary-500">LILCOPILGIT</h1>
          <button onClick={() => setSidebarOpen(!sidebarOpen)} className="text-gray-400 hover:text-white">
            {sidebarOpen ? <X size={24} /> : <Menu size={24} />}
          </button>
        </div>
        <main className="flex-1 overflow-y-auto p-6">
          <Outlet />
        </main>
      </div>
    </div>
  )
}
EOF

cat > frontend/src/pages/Dashboard.tsx << 'EOF'
import React from 'react'
import { TrendingUp, TrendingDown, Users, DollarSign, Activity } from 'lucide-react'
import { Link } from 'react-router-dom'

const metrics = [
  { name: 'Revenue', value: '$125,430', change: '+12%', trend: 'up', icon: DollarSign },
  { name: 'Active Users', value: '8,234', change: '+5%', trend: 'up', icon: Users },
  { name: 'Burn Rate', value: '-$45,000', change: '-8%', trend: 'down', icon: Activity },
]

export default function Dashboard() {
  return (
    <div>
      <div className="mb-8">
        <h2 className="text-3xl font-bold">CEO Dashboard</h2>
        <p className="text-gray-400 mt-2">Welcome back! Here's your command center</p>
      </div>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        {metrics.map((metric) => (
          <div key={metric.name} className="metric-card">
            <div className="flex items-center justify-between mb-4">
              <metric.icon className="h-8 w-8 text-primary-500" />
              <span className={`flex items-center text-sm font-medium ${
                metric.trend === 'up' ? 'text-green-500' : 'text-red-500'
              }`}>
                {metric.change}
                {metric.trend === 'up' ? <TrendingUp className="ml-1 h-4 w-4" /> : <TrendingDown className="ml-1 h-4 w-4" />}
              </span>
            </div>
            <p className="text-2xl font-bold">{metric.value}</p>
            <p className="text-gray-400 text-sm mt-1">{metric.name}</p>
          </div>
        ))}
      </div>

      <div className="card mb-8">
        <h3 className="text-xl font-semibold mb-4">Quick Actions</h3>
        <div className="flex flex-wrap gap-4">
          <Link to="/ceo-tasks" className="btn-primary">View CEO Tasks</Link>
          <Link to="/tg-analytics" className="btn-primary">TG Analytics</Link>
          <Link to="/ai-chat" className="btn-primary">AI Analysis</Link>
        </div>
      </div>

      <div className="card">
        <h3 className="text-xl font-semibold mb-4">21 CEO Tasks Progress</h3>
        <div className="mb-4">
          <div className="flex justify-between text-sm mb-2">
            <span>Overall Progress</span>
            <span className="font-medium">35% Complete</span>
          </div>
          <div className="w-full bg-dark-border rounded-full h-3">
            <div className="bg-primary-600 h-3 rounded-full" style={{ width: '35%' }}></div>
          </div>
        </div>
        <Link to="/ceo-tasks" className="text-primary-500 hover:text-primary-400 text-sm font-medium">
          View All Tasks →
        </Link>
      </div>
    </div>
  )
}
EOF

cat > frontend/src/pages/CeoTasks.tsx << 'EOF'
import React from 'react'
import { ChevronRight, AlertCircle, CheckCircle, Clock } from 'lucide-react'

const tasks = [
  {
    id: 1,
    phase: 'Emergency',
    phaseColor: 'text-red-500',
    title: 'Stop the Bleeding',
    progress: 40,
    status: 'in-progress',
    subtasks: [
      { title: 'Analyze expenses', done: true },
      { title: 'Cut ineffective channels', done: true },
      { title: 'Optimize infrastructure', done: false },
    ],
  },
  {
    id: 2,
    phase: 'Emergency',
    phaseColor: 'text-red-500',
    title: 'Data Audit',
    progress: 100,
    status: 'completed',
    subtasks: [
      { title: 'Collect all data sources', done: true },
      { title: 'Structure data', done: true },
      { title: 'Validate quality', done: true },
    ],
  },
  {
    id: 3,
    phase: 'Emergency',
    phaseColor: 'text-red-500',
    title: 'Team Assessment',
    progress: 60,
    status: 'in-progress',
    subtasks: [
      { title: 'Individual meetings', done: true },
      { title: 'Skills evaluation', done: true },
      { title: 'Restructuring plan', done: false },
    ],
  },
]

export default function CeoTasks() {
  return (
    <div>
      <div className="mb-8">
        <h2 className="text-3xl font-bold">21 CEO Tasks</h2>
        <p className="text-gray-400 mt-2">Your roadmap to turn around the business</p>
      </div>

      <div className="space-y-4">
        {tasks.map((task) => (
          <div key={task.id} className="card">
            <div className="flex items-start justify-between mb-4">
              <div>
                <span className={`text-xs font-medium ${task.phaseColor} uppercase tracking-wider`}>
                  {task.phase}
                </span>
                <h3 className="text-xl font-semibold mt-1">{task.title}</h3>
              </div>
              <div className="flex items-center">
                {task.status === 'completed' ? (
                  <CheckCircle className="h-5 w-5 text-green-500" />
                ) : task.status === 'in-progress' ? (
                  <Clock className="h-5 w-5 text-yellow-500" />
                ) : (
                  <AlertCircle className="h-5 w-5 text-gray-500" />
                )}
              </div>
            </div>

            <div className="mb-4">
              <div className="flex justify-between text-sm mb-2">
                <span>Progress</span>
                <span className="font-medium">{task.progress}%</span>
              </div>
              <div className="w-full bg-dark-border rounded-full h-2">
                <div className="bg-primary-600 h-2 rounded-full transition-all duration-300" style={{ width: `${task.progress}%` }}></div>
              </div>
            </div>

            <div className="space-y-2">
              {task.subtasks.map((subtask, index) => (
                <div key={index} className="flex items-center text-sm">
                  <input type="checkbox" checked={subtask.done} readOnly className="mr-2 h-4 w-4 rounded border-dark-border" />
                  <span className={subtask.done ? 'line-through text-gray-500' : ''}>{subtask.title}</span>
                </div>
              ))}
            </div>

            <div className="mt-4 flex justify-between items-center">
              <button className="text-primary-500 hover:text-primary-400 text-sm font-medium">Get AI Advice</button>
              <ChevronRight className="h-5 w-5 text-gray-400" />
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
EOF

cat > frontend/src/pages/TgAnalytics.tsx << 'EOF'
import React from 'react'
import { Upload, Search, Filter, Download } from 'lucide-react'

const channels = [
  { name: '@betting_pro', subs: '125K', er: '3.2%', cpm: '$45', score: 8.5 },
  { name: '@casino_vip', subs: '89K', er: '4.1%', cpm: '$38', score: 9.2 },
  { name: '@slots_club', subs: '67K', er: '2.9%', cpm: '$52', score: 7.8 },
]

export default function TgAnalytics() {
  return (
    <div>
      <div className="mb-8">
        <h2 className="text-3xl font-bold">Telegram Analytics</h2>
        <p className="text-gray-400 mt-2">Analyze and optimize your Telegram marketing</p>
      </div>

      <div className="flex flex-wrap gap-4 mb-8">
        <button className="btn-primary flex items-center">
          <Upload className="mr-2 h-4 w-4" />
          Upload Channels
        </button>
        <button className="btn-primary flex items-center">
          <Search className="mr-2 h-4 w-4" />
          Search
        </button>
        <button className="btn-primary flex items-center">
          <Filter className="mr-2 h-4 w-4" />
          Filter
        </button>
      </div>

      <div className="card mb-8">
        <h3 className="text-xl font-semibold mb-4">Your Channels</h3>
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr className="border-b border-dark-border">
                <th className="text-left py-3 px-4">Channel</th>
                <th className="text-left py-3 px-4">Subscribers</th>
                <th className="text-left py-3 px-4">ER%</th>
                <th className="text-left py-3 px-4">CPM</th>
                <th className="text-left py-3 px-4">Score</th>
                <th className="text-left py-3 px-4">Action</th>
              </tr>
            </thead>
            <tbody>
              {channels.map((channel) => (
                <tr key={channel.name} className="border-b border-dark-border/50">
                  <td className="py-3 px-4 font-medium">{channel.name}</td>
                  <td className="py-3 px-4">{channel.subs}</td>
                  <td className="py-3 px-4">{channel.er}</td>
                  <td className="py-3 px-4">{channel.cpm}</td>
                  <td className="py-3 px-4"><span className="text-primary-500 font-medium">{channel.score}</span></td>
                  <td className="py-3 px-4"><button className="text-primary-500 hover:text-primary-400 text-sm">Analyze</button></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>

      <div className="card">
        <h3 className="text-xl font-semibold mb-4">Competitor Analysis</h3>
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
          <div className="bg-dark-bg p-4 rounded-lg">
            <p className="text-3xl font-bold text-primary-500">67%</p>
            <p className="text-sm text-gray-400 mt-1">Audience Overlap</p>
          </div>
          <div className="bg-dark-bg p-4 rounded-lg">
            <p className="text-3xl font-bold text-green-500">23</p>
            <p className="text-sm text-gray-400 mt-1">Untapped Channels</p>
          </div>
          <div className="bg-dark-bg p-4 rounded-lg">
            <p className="text-3xl font-bold text-yellow-500">+45%</p>
            <p className="text-sm text-gray-400 mt-1">Traffic Potential</p>
          </div>
        </div>
      </div>
    </div>
  )
}
EOF

cat > frontend/src/pages/AiChat.tsx << 'EOF'
import React, { useState } from 'react'
import { Send, Bot, User } from 'lucide-react'

export default function AiChat() {
  const [message, setMessage] = useState('')
  const [messages, setMessages] = useState([
    { role: 'assistant', content: 'Hello! I\'m your AI assistant. How can I help you optimize your iGaming business today?' },
  ])

  const handleSend = () => {
    if (!message.trim()) return
    
    setMessages([...messages, { role: 'user', content: message }])
    setMessage('')
    
    setTimeout(() => {
      setMessages(prev => [...prev, {
        role: 'assistant',
        content: 'I\'m analyzing your request. This feature will be connected to Claude API soon!',
      }])
    }, 1000)
  }

  return (
    <div className="flex flex-col h-full">
      <div className="mb-6">
        <h2 className="text-3xl font-bold">AI Assistant</h2>
        <p className="text-gray-400 mt-2">Get intelligent insights and recommendations</p>
      </div>

      <div className="flex-1 card flex flex-col">
        <div className="flex-1 overflow-y-auto mb-4 space-y-4">
          {messages.map((msg, index) => (
            <div key={index} className={`flex ${msg.role === 'user' ? 'justify-end' : 'justify-start'}`}>
              <div className={`flex items-start max-w-[70%] ${msg.role === 'user' ? 'flex-row-reverse' : ''}`}>
                <div className={`flex-shrink-0 w-8 h-8 rounded-full flex items-center justify-center ${
                  msg.role === 'user' ? 'bg-primary-600 ml-2' : 'bg-gray-600 mr-2'
                }`}>
                  {msg.role === 'user' ? <User size={16} /> : <Bot size={16} />}
                </div>
                <div className={`px-4 py-2 rounded-lg ${
                  msg.role === 'user' ? 'bg-primary-600' : 'bg-dark-bg'
                }`}>
                  {msg.content}
                </div>
              </div>
            </div>
          ))}
        </div>

        <div className="flex gap-2">
          <input
            type="text"
            value={message}
            onChange={(e) => setMessage(e.target.value)}
            onKeyPress={(e) => e.key === 'Enter' && handleSend()}
            placeholder="Type your message..."
            className="flex-1 bg-dark-bg border border-dark-border rounded-lg px-4 py-2 focus:outline-none focus:border-primary-500"
          />
          <button onClick={handleSend} className="btn-primary flex items-center">
            <Send size={20} />
          </button>
        </div>
      </div>
    </div>
  )
}
EOF

# Create backend files
cat > backend/requirements.txt << 'EOF'
fastapi==0.109.2
uvicorn[standard]==0.27.1
pydantic==2.6.1
python-multipart==0.0.9
python-jose[cryptography]==3.3.0
passlib[bcrypt]==1.7.4
python-dotenv==1.0.1
httpx==0.26.0
anthropic==0.18.1
EOF

cat > backend/main.py << 'EOF'
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
EOF

# Create GitHub Actions
cat > .github/workflows/deploy.yml << 'EOF'
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Install dependencies
        run: |
          cd frontend
          npm install
          
      - name: Build project
        run: |
          cd frontend
          npm run build
          
      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./frontend/dist
EOF

# Create .env.local
echo "VITE_CLAUDE_API_KEY=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" > frontend/.env.local

# Create .gitignore
cat > .gitignore << 'EOF'
node_modules/
__pycache__/
*.pyc
.env
.env.local
dist/
build/
*.egg-info/
.vscode/
.idea/
*.swp
*.swo
.DS_Store
Thumbs.db
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*
EOF

echo "✅ Project created! Installing dependencies..."
cd frontend && npm install && cd ..
echo "✅ Dependencies installed!"
echo ""
echo "🚀 To start the project:"
echo "1. Frontend: cd frontend && npm run dev"
echo "2. Backend: cd backend && pip install -r requirements.txt && python main.py"
