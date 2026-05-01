// ===== Cấu hình =====
const datesEl = document.getElementById("dates");
const movieListEl = document.getElementById("movieList");
const qInput = document.getElementById("q");
const sortSelect = document.getElementById("sort");
let currentSelectedDate = datesEl.getAttribute("data-selected") || new Date().toISOString().split('T')[0];

// ===== Tạo 7 ngày chiếu =====
// ===== Khởi tạo sự kiện cho các tab ngày =====
function initDateEvents() {
    const dateTabs = document.querySelectorAll(".st-date");
    dateTabs.forEach(tab => {
        tab.addEventListener("click", () => {
            const iso = tab.getAttribute("data-iso");
            if (iso === currentSelectedDate) return;
            
            // Cập nhật UI active
            dateTabs.forEach(t => t.classList.remove("active"));
            tab.classList.add("active");
            
            currentSelectedDate = iso;
            fetchMovies();
        });
    });
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
initDateEvents();
// Không cần gọi fetchMovies() ở đây vì server đã render sẵn lần đầu
