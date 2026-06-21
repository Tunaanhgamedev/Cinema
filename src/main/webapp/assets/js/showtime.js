// ===== Date tabs: tạo 7 ngày =====
const datesEl = document.getElementById("dates");
const selectedDateAttr = datesEl.getAttribute("data-selected");
const urlParams = new URLSearchParams(window.location.search);
const currentSearch = urlParams.get('q') || "";

const makeDateLabel = (d) => {
  const days = ["CN","T2","T3","T4","T5","T6","T7"];
  const yyyy = d.getFullYear();
  const mm = String(d.getMonth() + 1).padStart(2, '0');
  const dd = String(d.getDate()).padStart(2, '0');
  const dateStr = `${yyyy}-${mm}-${dd}`;
  
  return {
    d1: days[d.getDay()],
    d2: `${dd}/${mm}`,
    iso: dateStr
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
    let url = window.location.pathname + "?date=" + iso;
    if(currentSearch) url += "&q=" + encodeURIComponent(currentSearch);
    window.location.href = url;
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
  if (val === "all" || !val) return true;
  return (attr || "").split(/\s+/).includes(val);
}

function apply(){
  const keyword = (q.value || "").trim().toLowerCase();
  const fVal = format ? format.value : "all";
  const lVal = lang ? lang.value : "all";

  let any = false;

  getMovies().forEach(item => {
    const title = (item.dataset.title || "").toLowerCase();
    const fAttr = (item.dataset.format || "");
    const lAttr = (item.dataset.lang || "");

    const okTitle = !keyword || title.includes(keyword);
    const okFormat = matchToken(fAttr, fVal);
    const okLang = matchToken(lAttr, lVal);

    const show = okTitle && okFormat && okLang;
    item.style.display = show ? "" : "none";
    if (show) any = true;
  });

  if (emptyState) {
    emptyState.style.display = any ? "none" : "block";
  }

  // sort
  if (sort && list) {
    const visible = getMovies().filter(x => x.style.display !== "none");
    visible.sort((a,b) => {
      if (sort.value === "hot"){
        return (Number(b.dataset.hot||0) - Number(a.dataset.hot||0)) || (a.dataset.title||"").localeCompare(b.dataset.title||"");
      }
      return (a.dataset.title||"").localeCompare(b.dataset.title||"");
    });
    visible.forEach(x => list.appendChild(x));
  }
}

if (q) q.addEventListener("input", apply);
if (format) format.addEventListener("change", apply);
if (lang) lang.addEventListener("change", apply);
if (sort) sort.addEventListener("change", apply);

if (btnClear) {
  btnClear.addEventListener("click", () => { q.value=""; apply(); });
}

// Initial apply
apply();
