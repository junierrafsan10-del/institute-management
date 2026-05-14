const items = [
  { label: 'Lab Session', gradient: 'linear-gradient(135deg, #00838F, #00ACC1)' },
  { label: 'Graduation Day', gradient: 'linear-gradient(135deg, #F57C00, #FF9800)' },
  { label: 'Industrial Visit', gradient: 'linear-gradient(135deg, #004D55, #00838F)' },
  { label: 'Sports Day', gradient: 'linear-gradient(135deg, #E53935, #FF7043)' },
  { label: 'Cultural Program', gradient: 'linear-gradient(135deg, #F57C00, #E53935)' },
  { label: 'Workshop', gradient: 'linear-gradient(135deg, #00ACC1, #4DD0E1)' },
  { label: 'Class Activity', gradient: 'linear-gradient(135deg, #43A047, #66BB6A)' },
  { label: 'Award Ceremony', gradient: 'linear-gradient(135deg, #F57C00, #FFC107)' },
]

export default function GalleryStrip() {
  return (
    <section style={{ background: '#1a1a1a' }} className="py-20 overflow-hidden">
      <div className="max-w-7xl mx-auto px-4 mb-10">
        <h2 className="text-3xl sm:text-4xl font-bold text-white text-center">
          Campus Life
        </h2>
      </div>

      <div className="gallery-track-wrapper">
        <div className="gallery-track">
          {[...items, ...items].map((item, i) => (
            <div
              key={i}
              className="gallery-card"
              style={{ background: item.gradient }}
            >
              <svg className="w-10 h-10 text-white/60 mb-2" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={1.5}>
                <path strokeLinecap="round" strokeLinejoin="round" d="M2.25 15.75l5.159-5.159a2.25 2.25 0 013.182 0l5.159 5.159m-1.5-1.5l1.409-1.409a2.25 2.25 0 013.182 0l2.909 2.909M3.75 21h16.5A2.25 2.25 0 0022.5 18.75V5.25A2.25 2.25 0 0020.25 3H3.75A2.25 2.25 0 001.5 5.25v13.5A2.25 2.25 0 003.75 21z" />
              </svg>
              <span className="text-white text-sm font-semibold">{item.label}</span>
            </div>
          ))}
        </div>
      </div>
    </section>
  )
}
