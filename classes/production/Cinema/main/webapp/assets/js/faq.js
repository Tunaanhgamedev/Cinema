(() => {
  const $ = (s, root=document) => root.querySelector(s);
  const $$ = (s, root=document) => Array.from(root.querySelectorAll(s));

  const searchInput = $("#faqSearch");
  const btnClear = $("#btnClear");
  const cats = $$("#faqCategories .cat");
  const chips = $$(".chip");
  const items = $$(".faq-item");
  const sections = $$(".faq-section");
  const empty = $("#faqEmpty");
  const count = $("#faqCount");

  let activeCat = "all";
  let keyword = "";

  // --- Accordion toggle (mở 1 cái, đóng cái khác)
  items.forEach(item => {
    const btn = $(".faq-q", item);
    btn.addEventListener("click", () => {
      const isOpen = item.classList.contains("open");
      items.forEach(x => x.classList.remove("open"));
      if (!isOpen) item.classList.add("open");
    });
  });

  // --- Highlight keyword trong text
  function clearMarks(el){
    // bỏ mark bằng cách khôi phục text HTML từ textContent
    const walker = document.createTreeWalker(el, NodeFilter.SHOW_TEXT);
    const texts = [];
    while (walker.nextNode()) texts.push(walker.currentNode);
    // thay mark cũ: nếu node nằm trong mark thì browser đã tạo element,
    // cách đơn giản là set lại innerHTML từ textContent theo đoạn dưới:
    // nhưng sẽ mất format ul/ol => ta chỉ highlight ở tiêu đề câu hỏi thôi (an toàn).
  }

  function highlightQuestionText(item, kw){
    const qEl = $(".faq-q-text", item);
    const raw = qEl.textContent;
    if (!kw) { qEl.innerHTML = raw; return; }

    const escaped = kw.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    const re = new RegExp(escaped, "ig");
    qEl.innerHTML = raw.replace(re, (m) => `<mark>${m}</mark>`);
  }

  // --- filter logic
  function apply(){
    const kw = (keyword || "").trim().toLowerCase();

    let visibleCount = 0;

    items.forEach(item => {
      // restore highlight first
      highlightQuestionText(item, "");

      const cat = item.dataset.cat || "";
      const qText = $(".faq-q-text", item).textContent.toLowerCase();
      const aText = $(".faq-a", item).textContent.toLowerCase();

      const okCat = (activeCat === "all") || (cat === activeCat);
      const okKw = !kw || qText.includes(kw) || aText.includes(kw);

      const show = okCat && okKw;
      item.style.display = show ? "" : "none";

      if (show){
        visibleCount++;
        // highlight ở câu hỏi (đẹp & không phá HTML đáp án)
        if (kw) highlightQuestionText(item, kw);
      }
    });

    // Ẩn section nếu không còn item nào hiện
    sections.forEach(sec => {
      const any = $$(".faq-item", sec).some(x => x.style.display !== "none");
      sec.style.display = any ? "" : "none";
    });

    empty.hidden = visibleCount !== 0;
    count.textContent = visibleCount ? `${visibleCount} câu hỏi phù hợp` : "";
  }

  // --- category click
  cats.forEach(btn => {
    btn.addEventListener("click", () => {
      cats.forEach(x => x.classList.remove("active"));
      btn.classList.add("active");
      activeCat = btn.dataset.cat || "all";
      apply();
    });
  });

  // --- search input
  searchInput.addEventListener("input", (e) => {
    keyword = e.target.value || "";
    apply();
  });

  btnClear.addEventListener("click", () => {
    keyword = "";
    searchInput.value = "";
    apply();
  });

  // --- chips: bấm là tự search + nhảy tới câu hỏi đầu tiên
  chips.forEach(chip => {
    chip.addEventListener("click", () => {
      const k = chip.dataset.key || "";
      keyword = k;
      searchInput.value = k;
      apply();

      // mở + scroll tới item đầu tiên đang visible
      const first = items.find(x => x.style.display !== "none");
      if (first){
        items.forEach(x => x.classList.remove("open"));
        first.classList.add("open");
        first.scrollIntoView({ behavior: "smooth", block: "center" });
      }
    });
  });

  // init
  apply();
})();
