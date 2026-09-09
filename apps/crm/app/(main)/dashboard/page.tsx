'use client'

import { useState } from 'react'

const initialDeals = [
  { id: '1', title: 'Website Redesign', value: 15000, company: 'Acme Corp', status: 'lead' },
  { id: '2', title: 'SEO Audit', value: 5000, company: 'TechStart', status: 'contacted' },
  { id: '3', title: 'Mobile App Dev', value: 45000, company: 'MegaCorp', status: 'qualified' },
  { id: '4', title: 'Cloud Migration', value: 25000, company: 'DataSystems', status: 'proposal' },
  { id: '5', title: 'IT Support Retainer', value: 12000, company: 'LocalBiz', status: 'won' },
]

const columns = [
  { id: 'lead', title: 'Lead' },
  { id: 'contacted', title: 'Contacted' },
  { id: 'qualified', title: 'Qualified' },
  { id: 'proposal', title: 'Proposal' },
  { id: 'won', title: 'Won' },
  { id: 'lost', title: 'Lost' },
]

export default function PipelinePage() {
  const [deals, setDeals] = useState(initialDeals)

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900 dark:text-white">Sales Pipeline</h1>
        <p className="text-sm text-gray-500 dark:text-gray-400">Drag and drop deals to update their status.</p>
      </div>

      <div className="flex space-x-4 overflow-x-auto pb-4">
        {columns.map((col) => {
          const columnDeals = deals.filter((d) => d.status === col.id)
          const columnTotal = columnDeals.reduce((sum, d) => sum + d.value, 0)

          return (
            <div key={col.id} className="w-80 flex-shrink-0 flex flex-col bg-gray-100 dark:bg-gray-800 rounded-lg p-3">
              <div className="flex justify-between items-center mb-4 px-1">
                <h3 className="font-semibold text-gray-700 dark:text-gray-200">{col.title}</h3>
                <span className="text-xs font-medium bg-gray-200 dark:bg-gray-700 text-gray-600 dark:text-gray-300 px-2 py-1 rounded-full">
                  ${(columnTotal / 1000).toFixed(1)}k
                </span>
              </div>
              
              <div className="flex-1 space-y-3">
                {columnDeals.map((deal) => (
                  <div 
                    key={deal.id}
                    className="bg-white dark:bg-gray-900 p-4 rounded-md shadow-sm border border-gray-200 dark:border-gray-700 cursor-grab hover:shadow-md transition-shadow"
                  >
                    <div className="flex justify-between items-start mb-2">
                      <h4 className="font-medium text-sm text-gray-900 dark:text-white">{deal.title}</h4>
                    </div>
                    <div className="text-sm text-gray-500 dark:text-gray-400 mb-2">
                      {deal.company}
                    </div>
                    <div className="font-semibold text-indigo-600 dark:text-indigo-400 text-sm">
                      ${deal.value.toLocaleString()}
                    </div>
                  </div>
                ))}
              </div>
            </div>
          )
        })}
      </div>
    </div>
  )
}
