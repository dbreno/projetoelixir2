function toggleMenu() {
    const navList = document.getElementById('nav-list');
    const menuIcon = document.querySelector('.menu-icon');
    const mainContent = document.querySelector('.section');
    
    if (!navList || !menuIcon) {
        console.error("Elementos navList ou menuIcon não encontrados!");
        return;
    }

    navList.classList.toggle('active');
    menuIcon.classList.toggle('active');

    // Calcular altura do menu quando estiver ativo
    if (navList.classList.contains('active')) {
        const navHeight = navList.scrollHeight; // Obter a altura total do menu
        mainContent.style.paddingTop = `${navHeight + 10}px`; // 60px é o valor do padding inicial no desktop
    } else {
        mainContent.style.paddingTop = "1rem"; // Espaçamento padrão
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const menuIcon = document.querySelector('.menu-icon');
    menuIcon.addEventListener('click', toggleMenu);
    
    const hiddenElementsH1 = document.querySelectorAll('.hidden-h1');
    const hiddenElementsp = document.querySelectorAll('.hidden-p');
    const hiddenElementGithubs = document.getElementById('hidden-githubs'); // Usar getElementById para um ID único

    const observerOptions = {
        root: null, // Usa a viewport como root
        threshold: 0.1 // Ativa quando 10% do elemento é visível
    };

    const observerCallback = (entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                if (entry.target.classList.contains('hidden-h1')) {
                    entry.target.classList.remove('hidden-h1');
                } else if (entry.target.classList.contains('hidden-p')) {
                    entry.target.classList.remove('hidden-p');
                } else if (entry.target.id === 'hidden-githubs') { // Verifica o ID corretamente
                    entry.target.classList.remove('hidden-githubs');
                }
            } else {
                if (!entry.target.classList.contains('hidden-h1') && entry.target.tagName === 'H1') {
                    entry.target.classList.add('hidden-h1');
                } else if (!entry.target.classList.contains('hidden-p') && entry.target.tagName === 'P') {
                    entry.target.classList.add('hidden-p');
                } else if (!entry.target.classList.contains('hidden-githubs') && entry.target.id === 'hidden-githubs') {
                    entry.target.classList.add('hidden-githubs'); // Adicionar classe corretamente
                }
            }
        });
    };

    const observer = new IntersectionObserver(observerCallback, observerOptions);

    hiddenElementsH1.forEach(element => {
        observer.observe(element);
    });

    hiddenElementsp.forEach(element => {
        observer.observe(element);
    });

    if (hiddenElementGithubs) { // Verifica se o elemento existe antes de observar
        observer.observe(hiddenElementGithubs);
    }
});