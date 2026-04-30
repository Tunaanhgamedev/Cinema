// ===== Date tabs: tạo 7 ngày =====
const datesEl = document.getElementById("dates");
const selectedDateAttr = datesEl.getAttribute("data-selected");

const makeDateLabel = (d) => {
  const days = ["CN","T2","T3","T4","T5","T6","T7"];
  return {
    d1: days[d.getDay()],
    d2: `${String(d.getDate()).padStart(2,"0")}/${String(d.getMonth()+1).padStart(2,"0")}`,
    iso: d.toISOString().split('T')[0]
  };
};

const today = new Date();
for (let i = 0; i < 7; i++){
  const d = new Date(today);
  d.setDate(today.getDate() + i);
  const {d1,d2,iso} = makeDateLabel(d);

  const div = document.createElement("div");
  div.className = "st-date" + (iso === selectedDateAttr ? " active" : "");
  div.innerHTML = `<div class="d1">${d1}</div><div class="d2">${d2}</div>`;
  div.addEventListener("click", () => {
    // Chuyển hướng trang kèm theo tham số ngày
    const currentPath = window.location.pathname;
    window.location.href = currentPath + "?date=" + iso;
  });
  datesEl.appendChild(div);
}

// ===== Filters =====
const q = document.getElementById("q");
const btnClear = document.getElementById("btnClear");
const list = document.getElementById("movieList");

const getMovies = () => Array.from(document.querySelectorAll(".st-movie"));

function apply(){
  const keyword = (q.value || "").trim().toLowerCase();
  let any = false;

  getMovies().forEach(item => {
    const title = (item.dataset.title || "").toLowerCase();
    const show = !keyword || title.includes(keyword);
    item.style.display = show ? "" : "none";
    if (show) any = true;
  });

  const emptyState = document.getElementById("emptyState");
  if(emptyState) emptyState.style.display = any ? "none" : "";
}

if(q) {
    q.addEventListener("input", apply);
    btnClear.addEventListener("click", () => { q.value=""; apply(); });
}

apply();
