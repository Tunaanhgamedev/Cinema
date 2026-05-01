// ===== Date tabs: tạo 7 ngày =====
const datesEl = document.getElementById("dates");
const selectedDateAttr = datesEl.getAttribute("data-selected");
const urlParams = new URLSearchParams(window.location.search);
const currentSearch = urlParams.get('q') || "";

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
    // Chuyển hướng trang kèm theo tham số ngày và GIỮ LẠI từ khóa tìm kiếm
    let url = window.location.pathname + "?date=" + iso;
    if(currentSearch) url += "&q=" + encodeURIComponent(currentSearch);
    window.location.href = url;
  });
  datesEl.appendChild(div);
}
