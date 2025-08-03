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
