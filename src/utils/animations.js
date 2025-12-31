// src/utils/animations.js
/**
 * 动画工具函数
 */

/**
 * 检查元素是否在视口中
 * @param {Element} element - DOM元素
 * @param {number} offset - 偏移量
 * @returns {boolean} 是否在视口中
 */
export const isInViewport = (element, offset = 0) => {
  if (!element) return false;
  
  const rect = element.getBoundingClientRect();
  return (
    rect.top <= (window.innerHeight || document.documentElement.clientHeight) - offset &&
    rect.bottom >= offset &&
    rect.left <= (window.innerWidth || document.documentElement.clientWidth) - offset &&
    rect.right >= offset
  );
};

/**
 * 为元素添加滚动动画
 * @param {string} selector - CSS选择器
 * @param {string} activeClass - 激活时添加的类名
 * @param {number} offset - 偏移量
 */
export const setupScrollAnimations = (selector = '.animate-on-scroll', activeClass = 'active', offset = 100) => {
  const elements = document.querySelectorAll(selector);
  
  const checkScroll = () => {
    elements.forEach(element => {
      if (isInViewport(element, offset)) {
        element.classList.add(activeClass);
      }
    });
  };
  
  // 初始检查
  checkScroll();
  
  // 监听滚动
  window.addEventListener('scroll', checkScroll);
  
  // 监听resize
  window.addEventListener('resize', checkScroll);
  
  return () => {
    window.removeEventListener('scroll', checkScroll);
    window.removeEventListener('resize', checkScroll);
  };
};

/**
 * 为元素添加点击波纹效果
 * @param {Element} element - DOM元素
 */
export const addRippleEffect = (element) => {
  element.classList.add('ripple');
  element.addEventListener('click', function(e) {
    const ripple = document.createElement('span');
    const rect = this.getBoundingClientRect();
    
    const size = Math.max(rect.width, rect.height);
    const x = e.clientX - rect.left - size / 2;
    const y = e.clientY - rect.top - size / 2;
    
    ripple.style.cssText = `
      position: absolute;
      border-radius: 50%;
      background: rgba(255, 255, 255, 0.7);
      transform: scale(0);
      animation: ripple 0.6s linear;
      width: ${size}px;
      height: ${size}px;
      top: ${y}px;
      left: ${x}px;
      pointer-events: none;
    `;
    
    this.appendChild(ripple);
    
    setTimeout(() => {
      ripple.remove();
    }, 600);
  });
};

/**
 * 执行动画
 * @param {Element} element - DOM元素
 * @param {string} animation - 动画名称
 * @param {Function} callback - 回调函数
 */
export const animateCSS = (element, animation, callback) => {
  const prefix = 'animate__';
  const animationName = `${prefix}${animation}`;
  const node = element;
  
  node.classList.add(`${prefix}animated`, animationName);
  
  function handleAnimationEnd() {
    node.classList.remove(`${prefix}animated`, animationName);
    node.removeEventListener('animationend', handleAnimationEnd);
    
    if (typeof callback === 'function') {
      callback();
    }
  }
  
  node.addEventListener('animationend', handleAnimationEnd);
};

/**
 * 顺序动画
 * @param {Array} elements - 元素数组
 * @param {string} animationClass - 动画类名
 * @param {number} delay - 延迟时间
 */
export const sequentialAnimation = (elements, animationClass, delay = 100) => {
  elements.forEach((element, index) => {
    setTimeout(() => {
      element.classList.add(animationClass);
    }, index * delay);
  });
};
