// ===== Cấu hình =====
const datesEl = document.getElementById("dates");
const movieListEl = document.getElementById("movieList");
const qInput = document.getElementById("q");
const sortSelect = document.getElementById("sort");
let currentSelectedDate = datesEl.getAttribute("data-selected") || new Date().toISOString().split('T')[0];

// ===== Tạo 7 ngày chiếu =====
const makeDateLabel = (d) => {
    const days = ["CN", "T2", "T3", "T4", "T5", "T6", "T7"];
    return {
        d1: days[d.getDay()],
        d2: `${String(d.getDate()).padStart(2, "0")}/${String(d.getMonth() + 1).padStart(2, "0")}`,
        iso: d.toISOString().split('T')[0]
    };
};

function renderDates() {
    datesEl.innerHTML = "";
    const today = new Date();
    for (let i = 0; i < 7; i++) {
        const d = new Date(today);
        d.setDate(today.getDate() + i);
        const { d1, d2, iso } = makeDateLabel(d);

        const div = document.createElement("div");
        div.className = "st-date" + (iso === currentSelectedDate ? " active" : "");
        div.innerHTML = `<div class="d1">${d1}</div><div class="d2">${d2}</div>`;
        div.addEventListener("click", () => {
            if (iso === currentSelectedDate) return;
            currentSelectedDate = iso;
            renderDates();
            fetchMovies();
        });
        datesEl.appendChild(div);
    }
}

// ===== AJAX Load Phim =====
async function fetchMovies() {
    const keyword = qInput.value.trim();
    const sort = sortSelect.value;
    
    // Hiệu ứng loading
    movieListEl.style.opacity = "0.5";
    movieListEl.style.pointerEvents = "none";

    try {
        const url = `${window.location.pathname}?date=${currentSelectedDate}&q=${encodeURIComponent(keyword)}&sort=${sort}&ajax=true`;
        const response = await fetch(url);
        if (!response.ok) throw new Error("Network error");
        
        const html = await response.text();
        movieListEl.innerHTML = html;
        
        // Cập nhật tiêu đề ngày hiển thị (nếu có element)
        const dateDisplay = document.querySelector(".st-sub span");
        if (dateDisplay) {
            const parts = currentSelectedDate.split("-");
            dateDisplay.textContent = `${parts[2]}/${parts[1]}/${parts[0]}`;
        }
    } catch (error) {
        console.error("Fetch error:", error);
        movieListEl.innerHTML = `<div class="alert alert-danger mx-auto mt-4" style="max-width: 500px">Có lỗi xảy ra khi tải dữ liệu. Vui lòng thử lại.</div>`;
    } finally {
        movieListEl.style.opacity = "1";
        movieListEl.style.pointerEvents = "auto";
    }
}

// ===== Debounce cho tìm kiếm =====
let searchTimeout;
qInput.addEventListener("input", () => {
    clearTimeout(searchTimeout);
    searchTimeout = setTimeout(fetchMovies, 500);
});

sortSelect.addEventListener("change", fetchMovies);

// Khởi tạo
renderDates();
// Không cần gọi fetchMovies() ở đây vì server đã render sẵn lần đầu
