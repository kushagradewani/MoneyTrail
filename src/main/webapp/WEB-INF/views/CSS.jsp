<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
html,body{
    height:100%;
    margin:0;
} 
html, body { height: 100%; overflow-y: auto; }
body{
    font-family:'Poppins',sans-serif;
    background:linear-gradient(135deg,#667eea,#764ba2);
    color:#fff;
}

/* GLASS EFFECT */
.glass{
    background:rgba(255,255,255,0.15);
    backdrop-filter:blur(15px);
    border-radius:18px;
    box-shadow:0 8px 32px rgba(0,0,0,0.2);
}

/* HEADER */
.header{
    padding:15px 25px;
}
.header h5{
    margin:0;
    font-weight:600;
}

/* LAYOUT */
.wrapper{
    min-height:100vh;
    padding:15px;
}
.sidebar{
    height:100%;
    padding:20px 0;
}
.sidebar a{
    display:block;
    padding:12px 25px;
    color:#fff;
    text-decoration:none;
    font-size:14px;
}
.sidebar a:hover,
.sidebar a.active{
    background:rgba(255,255,255,0.25);
}


/* FOOTER */
.footer{
    text-align:center;
    font-size:13px;
    opacity:0.85;
    padding:10px;
}

/* =========================
   FORM STYLING (GLOBAL)
   ========================= */

form label {
    font-size: 13px;
    font-weight: 500;
    margin-bottom: 6px;
}

/* Input & Select */
.form-control,
.form-select {
    background: rgba(255,255,255,0.2);
    border: none;
    border-radius: 14px;
    color: #fff;
    font-size: 14px;
    padding: 10px 14px;
    backdrop-filter: blur(10px);
    box-shadow: 0 6px 20px rgba(0,0,0,0.15);
    transition: all 0.25s ease;
}

/* Placeholder */
.form-control::placeholder {
    color: rgba(255,255,255,0.75);
}

/* Focus Effect */
.form-control:focus,
.form-select:focus {
    background: rgba(255,255,255,0.28);
    box-shadow: 0 0 0 2px rgba(255,255,255,0.35);
    outline: none;
    color: #fff;
}

/* Dropdown options */
.form-select option {
    color: #000;
}

/* Button */
.btn-custom {
    background: linear-gradient(135deg, #ff758c, #ff7eb3);
    border: none;
    border-radius: 30px;
    padding: 12px;
    font-size: 15px;
    font-weight: 600;
    letter-spacing: 0.5px;
    color: #fff;
    transition: all 0.3s ease;
}

/* Button hover */
.btn-custom:hover {
    transform: translateY(-2px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.3);
    opacity: 0.95;
}

/* Form card spacing */
.glass form {
    margin-top: 10px;
}

/* Center form nicely */
.glass .col-md-6 {
    animation: fadeUp 0.5s ease;
}

/* Animation *//*
@keyframes fadeUp {
    from {
        opacity: 0;
        transform: translateY(15px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}*/

</style>