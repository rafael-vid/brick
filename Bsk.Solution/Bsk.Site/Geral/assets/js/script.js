//menu mobile
const btnMobile = document.getElementById('btn-mobile')

function toggleMenu(e) {
  if (e.type === 'touchstart') e.preventDefault()
  const nav = document.getElementById('nav')
  nav.classList.toggle('active')
}

//dropfow menu
if (btnMobile) {
    btnMobile.addEventListener("click", toggleMenu);
    btnMobile.addEventListener("touchstart", toggleMenu);
} else {
    console.error("Element #btnMobile not found!");
}

const dropdowMenus = document.querySelectorAll('[data-dropdown]')

dropdowMenus.forEach(menu => {
  ['touchstart', 'click'].forEach(e => {
    menu.addEventListener(e, handleClick)
  })
})

function handleClick(event){
  this.classList.toggle('ativo-submenu')
  clicouFora( this,  () =>{
    this.classList.remove('ativo-submenu')
  })
}

  function clicouFora(element, callback){
    const outside =  'data-outside'
    const html = document.documentElement
    if(!element.hasAttribute(outside)){
      html.addEventListener('click', (e) => {
      if(!element.contains(e.target)){
        html.removeEventListener('click', this)
        callback()
      }
    })
  }
}

document.addEventListener('DOMContentLoaded', () => {
    const menuToggle = document.querySelector('.open-menu');
    if (menuToggle) {
        menuToggle.addEventListener('click', () => {
            const app = document.querySelector('.app');
            if (app) {
                app.classList.toggle('mini-menu');
            }
        });
    } else {
        console.error("Elemento '.open-menu' não encontrado!");
    }
});
  
    
function submenu(){
  const dropdow = document.querySelectorAll('[data-dropdow-perfil]')

  dropdow.forEach(menu => {
    ['touchstart', 'click'].forEach(userEvent => {
      menu.addEventListener(userEvent, handleClick)
    })
  })

  function handleClick(event) {
    this.classList.add('active-submenu')
    outsideClick(this, () =>{
      this.classList.remove('active-submenu')
    })
  }

  function outsideClick(element, callback){
    const html = document.documentElement
    const outside = 'data-outside'

    if(!element.hasAttribute(outside)) {
      html.addEventListener('click', handleOutsideClick)
      element.setAttribute(outside, '')
    }

    function handleOutsideClick (event){
      if(!element.contains(event.target)){
        element.removeAttribute(outside)
        html.removeEventListener('click', handleOutsideClick)
        callback()
      }
    }
  }

}
submenu()
document.addEventListener('DOMContentLoaded', function () {
    const btnCadastro = document.querySelector('.btn-cadastro').parentElement; // Seleciona o <li> do botão

    function handleResponsiveMenu() {
        if (window.innerWidth < 758) {
            btnCadastro.style.display = 'none'; // Esconde o elemento
        } else {
            btnCadastro.style.display = ''; // Mostra o elemento (ou mantém o estilo padrão)
        }
    }

    // Executa a função ao carregar a página
    handleResponsiveMenu();

    // Adiciona um event listener para mudanças no tamanho da tela
    window.addEventListener('resize', handleResponsiveMenu);
});
document.addEventListener('DOMContentLoaded', function () {
    const btnCadastro = document.querySelector('.btn-cadastro-mobile'); // Seleciona o <li> do botão

    function handleResponsiveMenu() {
        if (window.innerWidth > 758) {
            btnCadastro.style.display = 'none'; // Esconde o elemento
        } else {
            btnCadastro.style.display = ''; // Mostra o elemento (ou mantém o estilo padrão)
        }
    }

    // Executa a função ao carregar a página
    handleResponsiveMenu();

    // Adiciona um event listener para mudanças no tamanho da tela
    window.addEventListener('resize', handleResponsiveMenu);
});
const btnMobile = document.getElementById("btnMobile");

