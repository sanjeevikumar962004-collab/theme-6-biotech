import re

with open('contact.html', 'r', encoding='utf-8') as f:
    text = f.read()

# Replace title and meta
text = re.sub(r'<title>.*?</title>', '<title>Contact Us - Stackly Biotech</title>', text)
text = re.sub(r'<meta content="Stackly pioneers[^"]+" name="description" />', '<meta content="Get in touch with Stackly Biotech for inquiries, support, and partnerships." name="description" />', text)

# Replace style block
new_style = """<style>
      /* --- CONTACT PAGE STYLES --- */
      body { font-family: 'Plus Jakarta Sans', sans-serif; background: #f8fafc; overflow-x: hidden; }
      .contact-page-wrapper { padding-top: 0; min-height: 100vh; }
      
      /* 1. HERO SECTION */
      .contact-hero {
        padding: 180px 20px 140px; text-align: center; position: relative;
        background: linear-gradient(rgba(1, 58, 101, 0.75), rgba(1, 58, 101, 0.95)), url('images/pexels-edward-jenner-4033149.webp') center/cover no-repeat;
      }
      .contact-badge {
        display: inline-block; padding: 8px 18px; background: rgba(255, 255, 255, 0.15); color: #fff;
        backdrop-filter: blur(8px); border: 1px solid rgba(255, 255, 255, 0.2); font-weight: 800; border-radius: 100px;
        font-size: 13px; margin-bottom: 24px; letter-spacing: 0.5px; text-transform: uppercase;
      }
      .contact-hero h1 { font-size: 64px; font-weight: 800; color: #ffffff; margin-bottom: 24px; letter-spacing: -2.5px; line-height: 1.1; }
      .contact-hero p { font-size: 20px; color: #e2e8f0; max-width: 600px; margin: 0 auto; line-height: 1.6; font-weight: 500; }

      /* 2. CONTACT CONTENT SECTION */
      .contact-content {
        padding: 100px 20px; max-width: 1240px; margin: 0 auto; display: grid; grid-template-columns: 1fr 1.3fr; gap: 60px; align-items: start;
      }
      .contact-info-panel { display: flex; flex-direction: column; gap: 40px; }
      .info-card { background: #fff; padding: 40px; border-radius: 24px; box-shadow: 0 20px 40px -10px rgba(0,0,0,0.06); border: 1px solid #e2e8f0; }
      .info-card h3 { font-size: 24px; font-weight: 800; color: #0f172a; margin-bottom: 8px; letter-spacing: -0.5px; }
      .info-card p { font-size: 16px; color: #64748b; margin-bottom: 24px; line-height: 1.6; }
      .info-detail { display: flex; align-items: center; gap: 16px; margin-bottom: 16px; }
      .info-icon { width: 48px; height: 48px; border-radius: 50%; background: #eff6ff; color: #2563eb; display: flex; align-items: center; justify-content: center; font-size: 20px; flex-shrink: 0; }
      .info-icon svg { width: 24px; height: 24px; stroke: currentColor; stroke-width: 2; fill: none; }
      .info-text a { font-size: 16px; font-weight: 700; color: #0f172a; text-decoration: none; transition: color 0.2s; }
      .info-text a:hover { color: #2563eb; }
      .info-text span { display: block; font-size: 14px; color: #64748b; font-weight: 500; }

      /* Form Panel */
      .contact-form-panel { background: #fff; padding: 50px; border-radius: 24px; box-shadow: 0 20px 40px -10px rgba(0,0,0,0.06); border: 1px solid #e2e8f0; }
      .contact-form-panel h2 { font-size: 32px; font-weight: 800; color: #0f172a; margin-bottom: 12px; letter-spacing: -1px; }
      .contact-form-panel > p { font-size: 16px; color: #64748b; margin-bottom: 32px; line-height: 1.6; }
      .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px 24px; }
      .form-group { display: flex; flex-direction: column; gap: 8px; }
      .form-group.full-width { grid-column: 1 / -1; }
      .form-group label { font-size: 14px; font-weight: 700; color: #334155; }
      .form-ip { padding: 16px 20px; border-radius: 12px; border: 1px solid #cbd5e1; background: #f8fafc; color: #0f172a; font-family: inherit; font-size: 15px; outline: none; transition: all 0.3s; }
      .form-ip:focus { border-color: #3b82f6; background: #fff; box-shadow: 0 0 0 4px rgba(59,130,246,0.1); }
      .form-ip::placeholder { color: #94a3b8; }
      textarea.form-ip { resize: vertical; min-height: 140px; }
      .submit-btn { margin-top: 12px; padding: 18px 40px; border-radius: 12px; background: #2563eb; color: #fff; font-weight: 700; font-size: 16px; border: none; cursor: pointer; transition: background 0.3s, transform 0.2s; width: 100%; }
      .submit-btn:hover { background: #1d4ed8; transform: translateY(-2px); }

      /* RESPONSIVENESS */
      @media(max-width: 992px) { .contact-content { grid-template-columns: 1fr; gap: 40px; padding: 60px 20px; } }
      @media(max-width: 768px) { .contact-hero h1 { font-size: 44px; } .form-grid { grid-template-columns: 1fr; } .contact-form-panel { padding: 30px; } }
    </style>"""
text = re.sub(r'<style>.*?</style>', new_style, text, flags=re.DOTALL)

# Replace main block
new_main = """<main class="contact-page-wrapper">
      <section class="contact-hero">
        <div class="blog-container">
          <div class="contact-badge" data-aos="fade-down" data-aos-delay="100">Contact Us</div>
          <h1 data-aos="fade-up" data-aos-delay="200">Let's build the future together.</h1>
          <p data-aos="fade-up" data-aos-delay="300">Whether you're exploring clinical partnerships, interested in our genomic pipeline, or seeking support, our team is ready to help.</p>
        </div>
      </section>

      <section class="contact-content">
        <!-- Left: Contact Details -->
        <div class="contact-info-panel" data-aos="fade-right" data-aos-delay="400">
          <div class="info-card">
            <h3>Our Headquarters</h3>
            <p>Come visit us at the Stackly Innovation Center in California for inquiries or partnerships.</p>
            <div class="info-detail">
              <div class="info-icon"><svg viewBox="0 0 24 24"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"></path><circle cx="12" cy="10" r="3"></circle></svg></div>
              <div class="info-text">
                <a href="#">410 Sandtown Road</a>
                <span>California 94001, USA</span>
              </div>
            </div>
          </div>
          
          <div class="info-card">
            <h3>Get in Touch</h3>
            <p>Reach out directly to our dedicated scientific and business development teams.</p>
            <div class="info-detail">
              <div class="info-icon"><svg viewBox="0 0 24 24"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg></div>
              <div class="info-text">
                <a href="mailto:info@stackly.io">info@stackly.io</a>
                <span>Average response: 24h</span>
              </div>
            </div>
            <div class="info-detail">
              <div class="info-icon"><svg viewBox="0 0 24 24"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg></div>
              <div class="info-text">
                <a href="tel:8884567890">(888) 456 7890</a>
                <span>Mon-Fri 9am - 6pm PST</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Right: Contact Form -->
        <div class="contact-form-panel" data-aos="fade-left" data-aos-delay="500">
          <h2>Send us a message</h2>
          <p>Fill out the form below and one of our biomedical specialists will get back to you shortly.</p>
          <form class="form-grid" action="404.html">
            <div class="form-group">
              <label>First Name</label>
              <input type="text" class="form-ip" placeholder="Jane" required />
            </div>
            <div class="form-group">
              <label>Last Name</label>
              <input type="text" class="form-ip" placeholder="Doe" required />
            </div>
            <div class="form-group">
              <label>Work Email</label>
              <input type="email" class="form-ip" placeholder="jane@company.com" required />
            </div>
            <div class="form-group">
              <label>Phone Number</label>
              <input type="tel" class="form-ip" placeholder="+1 (555) 000-0000" />
            </div>
            <div class="form-group full-width">
              <label>Subject / Topic</label>
              <input type="text" class="form-ip" placeholder="Clinical Trials, Partnership, or General Inquiry" required />
            </div>
            <div class="form-group full-width">
              <label>Your Message</label>
              <textarea class="form-ip" placeholder="How can we help you?" required></textarea>
            </div>
            <div class="form-group full-width">
              <button type="submit" class="submit-btn" onclick="event.preventDefault(); window.location.href='404.html';">Send Message</button>
            </div>
          </form>
        </div>
      </section>
    </main>"""
text = re.sub(r'<main>.*?</main>|<main class="blog-page-wrapper">.*?</main>', new_main, text, flags=re.DOTALL)

with open('contact.html', 'w', encoding='utf-8') as f:
    f.write(text)

print("Contact page successfully built.")
