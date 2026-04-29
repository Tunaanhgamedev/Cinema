// ===== Date tabs: tạo 7 ngày =====
const datesEl = document.getElementById("dates");
const makeDateLabel = (d) => {
  const days = ["CN","T2","T3","T4","T5","T6","T7"];
  return {
    d1: days[d.getDay()],
    d2: `${String(d.getDate()).padStart(2,"0")}/${String(d.getMonth()+1).padStart(2,"0")}`
  };
};

const today = new Date();
for (let i = 0; i < 7; i++){
  const d = new Date(today);
  d.setDate(today.getDate() + i);
  const {d1,d2} = makeDateLabel(d);

  const div = document.createElement("div");
  div.className = "st-date" + (i===0 ? " active" : "");
  div.innerHTML = `<div class="d1">${d1}</div><div class="d2">${d2}</div>`;
  div.addEventListener("click", () => {
    document.querySelectorAll(".st-date").forEach(x => x.classList.remove("active"));
    div.classList.add("active");
    // Demo: chưa đổi dữ liệu theo ngày (khi nối DB sẽ render theo ngày)
  });
  datesEl.appendChild(div);
}

// ===== Filters =====
const q = document.getElementById("q");
const btnClear = document.getElementById("btnClear");
const format = document.getElementById("format");
const lang = document.getElementById("lang");
const sort = document.getElementById("sort");
const list = document.getElementById("movieList");
const emptyState = document.getElementById("emptyState");

const getMovies = () => Array.from(document.querySelectorAll(".st-movie"));

function matchToken(attr, val){
  if (val === "all") return true;
  return (attr || "").split(/\s+/).includes(val);
}

function apply(){
  const keyword = (q.value || "").trim().toLowerCase();
  const fVal = format.value;
  const lVal = lang.value;

  let any = false;

  getMovies().forEach(item => {
    const title = (item.dataset.title || "");
    const fAttr = (item.dataset.format || "");
    const lAttr = (item.dataset.lang || "");

    const okTitle = !keyword || title.includes(keyword);
    const okFormat = matchToken(fAttr, fVal);
    const okLang = matchToken(lAttr, lVal);

    const show = okTitle && okFormat && okLang;
    item.style.display = show ? "" : "none";
    if (show) any = true;
  });

  emptyState.style.display = any ? "none" : "";

  // sort
  const visible = getMovies().filter(x => x.style.display !== "none");
  visible.sort((a,b) => {
    if (sort.value === "hot"){
      return (Number(b.dataset.hot||0) - Number(a.dataset.hot||0)) || (a.dataset.title||"").localeCompare(b.dataset.title||"");
    }
    return (a.dataset.title||"").localeCompare(b.dataset.title||"");
  });
  visible.forEach(x => list.appendChild(x));
}

[q, format, lang, sort].forEach(el => el.addEventListener("input", apply));
btnClear.addEventListener("click", () => { q.value=""; apply(); });

apply();
