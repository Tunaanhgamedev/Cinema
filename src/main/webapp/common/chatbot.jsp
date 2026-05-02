<!-- BobiBot - AI Cinema Assistant -->
<div id="ai-chatbot-wrapper" class="fixed bottom-8 right-8 z-[999] font-['Outfit']">
    <!-- Chat Toggle Button -->
    <button id="chatbot-toggle" class="w-16 h-16 bg-gradient-to-tr from-red-600 to-rose-600 rounded-full shadow-2xl flex items-center justify-center text-white text-2xl hover:scale-110 transition-all group">
        <i class="fas fa-robot group-hover:rotate-12 transition-transform"></i>
        <span class="absolute -top-1 -right-1 w-5 h-5 bg-green-500 border-2 border-slate-900 rounded-full"></span>
    </button>

    <!-- Chat Window -->
    <div id="chatbot-window" class="absolute bottom-20 right-0 w-[380px] h-[550px] bg-slate-900/95 backdrop-blur-2xl border border-white/10 rounded-[2.5rem] shadow-2xl flex flex-col overflow-hidden hidden scale-90 opacity-0 origin-bottom-right transition-all duration-300">
        <!-- Header -->
        <div class="p-6 bg-white/5 border-b border-white/5 flex items-center justify-between">
            <div class="flex items-center gap-4">
                <div class="w-12 h-12 bg-red-600/20 rounded-2xl flex items-center justify-center text-red-500">
                    <i class="fas fa-robot text-xl"></i>
                </div>
                <div>
                    <h3 class="font-bold text-white">BobiBot AI</h3>
                    <p class="text-[10px] text-green-400 font-bold uppercase tracking-widest flex items-center gap-1">
                        <span class="w-1.5 h-1.5 bg-green-500 rounded-full animate-pulse"></span> Online
                    </p>
                </div>
            </div>
            <button id="chatbot-close" class="text-slate-400 hover:text-white transition-colors">
                <i class="fas fa-times text-xl"></i>
            </button>
        </div>

        <!-- Messages Area -->
        <div id="chatbot-messages" class="flex-1 overflow-y-auto p-6 space-y-4 scroll-smooth">
            <!-- Bot Welcome -->
            <div class="bot-msg flex gap-3">
                <div class="w-8 h-8 rounded-full bg-slate-800 flex-shrink-0 flex items-center justify-center text-xs text-red-500 border border-white/5">
                    <i class="fas fa-robot"></i>
                </div>
                <div class="bg-white/5 border border-white/5 rounded-2xl rounded-tl-none p-4 text-sm text-slate-300 max-w-[85%]">
                    Chào bạn! Tôi là BobiBot. Bạn cần tôi tư vấn phim hay hay giải đáp thắc mắc gì không? 🍿
                </div>
            </div>
        </div>

        <!-- Input Area -->
        <div class="p-4 bg-white/5 border-t border-white/5">
            <div class="relative flex items-center gap-2 bg-slate-950 border border-white/10 rounded-2xl p-2 focus-within:border-red-500 transition-all">
                <input type="text" id="chatbot-input" placeholder="Hỏi BobiBot bất cứ điều gì..." 
                       class="flex-1 bg-transparent border-none outline-none text-white px-3 py-2 text-sm">
                <button id="chatbot-send" class="w-10 h-10 bg-red-600 hover:bg-red-500 rounded-xl flex items-center justify-center text-white transition-all">
                    <i class="fas fa-paper-plane"></i>
                </button>
            </div>
            <p class="text-[10px] text-center text-slate-500 mt-3 uppercase font-bold tracking-tighter">Powered by BOBIXI Cinema AI</p>
        </div>
    </div>
</div>

<style>
    #chatbot-window.active {
        display: flex;
        transform: scale(1);
        opacity: 1;
    }
    .user-msg { justify-content: flex-end; }
    .user-msg .content {
        background: linear-gradient(135deg, #ef4444 0%, #be123c 100%);
        color: white;
        border-radius: 1.25rem 1.25rem 0 1.25rem;
    }
    #chatbot-messages::-webkit-scrollbar { width: 4px; }
    #chatbot-messages::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.1); border-radius: 10px; }
    
    @keyframes typing {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-3px); }
    }
    .typing-dot {
        width: 4px; height: 4px; background: #64748b; border-radius: 50%;
        animation: typing 1s infinite;
    }
</style>

<script>
    const chatToggle = document.getElementById('chatbot-toggle');
    const chatWindow = document.getElementById('chatbot-window');
    const chatClose = document.getElementById('chatbot-close');
    const chatInput = document.getElementById('chatbot-input');
    const chatSend = document.getElementById('chatbot-send');
    const chatMessages = document.getElementById('chatbot-messages');

    chatToggle.onclick = () => chatWindow.classList.toggle('active');
    chatClose.onclick = () => chatWindow.classList.remove('active');

    function addMessage(text, isBot = true) {
        const msgDiv = document.createElement('div');
        msgDiv.className = isBot ? 'bot-msg flex gap-3' : 'user-msg flex gap-3';
        
        const avatar = isBot ? 
            `<div class="w-8 h-8 rounded-full bg-slate-800 flex-shrink-0 flex items-center justify-center text-xs text-red-500 border border-white/5"><i class="fas fa-robot"></i></div>` : 
            '';

        const contentClass = isBot ? 
            'bg-white/5 border border-white/5 rounded-2xl rounded-tl-none p-4 text-sm text-slate-300 max-w-[85%]' : 
            'content p-4 text-sm max-w-[85%] shadow-lg shadow-red-900/20';

        msgDiv.innerHTML = `
            ${avatar}
            <div class="${contentClass}">
                ${text}
            </div>
        `;
        chatMessages.appendChild(msgDiv);
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }

    async function sendMessage() {
        const msg = chatInput.value.trim();
        if (!msg) return;

        addMessage(msg, false);
        chatInput.value = '';

        // Typing indicator
        const typingId = 'typing-' + Date.now();
        const typingDiv = document.createElement('div');
        typingDiv.id = typingId;
        typingDiv.className = 'bot-msg flex gap-3';
        typingDiv.innerHTML = `
            <div class="w-8 h-8 rounded-full bg-slate-800 flex-shrink-0 flex items-center justify-center text-xs text-red-500 border border-white/5"><i class="fas fa-robot"></i></div>
            <div class="bg-white/5 border border-white/5 rounded-2xl rounded-tl-none p-4 flex gap-1">
                <div class="typing-dot"></div>
                <div class="typing-dot" style="animation-delay: 0.2s"></div>
                <div class="typing-dot" style="animation-delay: 0.4s"></div>
            </div>
        `;
        chatMessages.appendChild(typingDiv);
        chatMessages.scrollTop = chatMessages.scrollHeight;

        try {
            const response = await fetch('${pageContext.request.contextPath}/api/ai/chat', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ message: msg })
            });
            const data = await response.json();
            document.getElementById(typingId).remove();
            addMessage(data.reply);
        } catch (err) {
            document.getElementById(typingId).remove();
            addMessage('Rất tiếc, tôi đang gặp lỗi kết nối. Hãy thử lại sau ít phút nhé! 😅');
        }
    }

    chatSend.onclick = sendMessage;
    chatInput.onkeypress = (e) => { if (e.key === 'Enter') sendMessage(); };
</script>
