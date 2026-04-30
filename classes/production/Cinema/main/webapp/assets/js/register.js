(() => {
  const $ = (s, root=document) => root.querySelector(s);

  const form = $("#register-form");
  if (!form) return;

  const email = $("#email");
  const phone = $("#phone");
  const password = $("#password");
  const confirmPassword = $("#confirm-password");
  const agree = $("#agree-terms");

  const strengthBox = $("#password-strength");
  const meter = $(".strength-meter");
  const strengthText = $(".strength-text");

  // ----- Helper: show error dưới input
  function setError(input, message){
    clearError(input);
    const box = input.closest(".input-box") || input.parentElement;
    const div = document.createElement("div");
    div.className = "field-error";
    div.style.cssText = "margin-top:8px;color:#b91c1c;font-weight:800;font-size:.92rem;";
    div.textContent = message;
    box.appendChild(div);
    input.style.borderColor = "rgba(185,28,28,.55)";
    input.style.boxShadow = "0 0 0 4px rgba(185,28,28,.10)";
  }

  function clearError(input){
    const box = input.closest(".input-box") || input.parentElement;
    const err = box.querySelector(".field-error");
    if (err) err.remove();
    input.style.borderColor = "";
    input.style.boxShadow = "";
  }

  // ----- Password strength
  function checkPasswordStrength(pw) {
    let score = 0;

    if (!pw || pw.length === 0) {
      return { percent: 0, class: "", text: "" };
    }

    // Length
    if (pw.length >= 8) score += 25;
    else if (pw.length >= 6) score += 15;

    // Lower/Upper
    if (/[a-z]/.test(pw)) score += 25;
    if (/[A-Z]/.test(pw)) score += 25;

    // Number
    if (/\d/.test(pw)) score += 15;

    // Special
    if (/[^A-Za-z0-9]/.test(pw)) score += 10;

    let cls = "weak", txt = "Yếu";
    if (score < 30) { cls="weak"; txt="Yếu"; }
    else if (score < 60) { cls="medium"; txt="Trung bình"; }
    else if (score < 80) { cls="strong"; txt="Mạnh"; }
    else { cls="very-strong"; txt="Rất mạnh"; }

    return { percent: Math.min(score, 100), class: cls, text: txt };
  }

  password.addEventListener("input", () => {
    const s = checkPasswordStrength(password.value);
    strengthBox.style.display = password.value ? "flex" : "none";
    meter.style.width = s.percent + "%";
    meter.className = "strength-meter " + (s.class || "");
    strengthText.textContent = s.text || "";
  });

  // ----- Live clear error
  [email, phone, password, confirmPassword].forEach(inp => {
    inp.addEventListener("input", () => clearError(inp));
  });

  // ----- Submit validation
  form.addEventListener("submit", (e) => {
    let ok = true;

    const emailVal = (email.value || "").trim();
    const phoneVal = (phone.value || "").trim();
    const pwVal = password.value || "";
    const cpwVal = confirmPassword.value || "";

    // Email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(emailVal)){
      setError(email, "Email không hợp lệ");
      ok = false;
    }

    // Phone (10-11 digits)
    const phoneRegex = /^[0-9]{10,11}$/;
    if (!phoneRegex.test(phoneVal)){
      setError(phone, "Số điện thoại không hợp lệ (10–11 số)");
      ok = false;
    }

    // Password length
    if (pwVal.length < 6){
      setError(password, "Mật khẩu phải có ít nhất 6 ký tự");
      ok = false;
    }

    // Confirm password
    if (pwVal !== cpwVal){
      setError(confirmPassword, "Mật khẩu xác nhận không khớp");
      ok = false;
    }

    // Agree terms
    if (!agree.checked){
      // checkbox nằm ngoài input-box nên báo kiểu alert nhẹ (khỏi phá layout)
      alert("Vui lòng đồng ý với điều khoản sử dụng và chính sách bảo mật.");
      ok = false;
    }

    if (!ok){
      e.preventDefault();
    }
  });
})();
