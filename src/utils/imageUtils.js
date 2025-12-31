// src/utils/imageUtils.js
/**
 * 图片压缩工具函数
 */

/**
 * 压缩图片
 * @param {File} file - 图片文件
 * @param {Object} options - 压缩选项
 * @param {number} options.maxWidth - 最大宽度
 * @param {number} options.maxHeight - 最大高度
 * @param {number} options.quality - 压缩质量 (0-1)
 * @returns {Promise<string>} 返回base64字符串
 */
export const compressImage = (file, options = {}) => {
  return new Promise((resolve, reject) => {
    const {
      maxWidth = 800,
      maxHeight = 800,
      quality = 0.8
    } = options;

    // 检查文件类型
    if (!file.type.startsWith('image/')) {
      reject(new Error('请选择图片文件'));
      return;
    }

    // 检查文件大小（限制5MB）
    if (file.size > 5 * 1024 * 1024) {
      reject(new Error('图片大小不能超过5MB'));
      return;
    }

    const reader = new FileReader();
    
    reader.onload = (e) => {
      const imageData = e.target.result;
      const img = new Image();
      
      img.onload = () => {
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d');
        
        let width = img.width;
        let height = img.height;
        
        // 计算缩放比例
        if (width > height) {
          if (width > maxWidth) {
            height *= maxWidth / width;
            width = maxWidth;
          }
        } else {
          if (height > maxHeight) {
            width *= maxHeight / height;
            height = maxHeight;
          }
        }
        
        canvas.width = width;
        canvas.height = height;
        
        // 绘制压缩后的图片
        ctx.drawImage(img, 0, 0, width, height);
        
        // 转换为base64
        const compressedData = canvas.toDataURL('image/jpeg', quality);
        resolve(compressedData);
      };
      
      img.onerror = () => {
        reject(new Error('图片加载失败'));
      };
      
      img.src = imageData;
    };
    
    reader.onerror = () => {
      reject(new Error('文件读取失败'));
    };
    
    reader.readAsDataURL(file);
  });
};

/**
 * 从base64获取文件大小
 * @param {string} base64 - base64字符串
 * @returns {number} 文件大小（字节）
 */
export const getBase64Size = (base64) => {
  const stringLength = base64.length - 'data:image/jpeg;base64,'.length;
  const sizeInBytes = 4 * Math.ceil(stringLength / 3) * 0.5624896334383812;
  return sizeInBytes;
};

/**
 * 检查图片文件
 * @param {File} file - 图片文件
 * @param {Object} options - 检查选项
 * @returns {Promise<boolean>} 是否通过检查
 */
export const checkImageFile = (file, options = {}) => {
  return new Promise((resolve, reject) => {
    const {
      maxSize = 5 * 1024 * 1024, // 5MB
      allowedTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/webp']
    } = options;

    // 检查文件类型
    if (!allowedTypes.includes(file.type)) {
      reject(new Error(`仅支持以下图片格式: ${allowedTypes.join(', ')}`));
      return;
    }

    // 检查文件大小
    if (file.size > maxSize) {
      reject(new Error(`图片大小不能超过${maxSize / 1024 / 1024}MB`));
      return;
    }

    // 检查图片尺寸
    const img = new Image();
    const reader = new FileReader();
    
    reader.onload = (e) => {
      img.onload = () => {
        if (img.width > 5000 || img.height > 5000) {
          reject(new Error('图片尺寸过大'));
        } else {
          resolve(true);
        }
      };
      img.onerror = () => {
        reject(new Error('无法读取图片尺寸'));
      };
      img.src = e.target.result;
    };
    
    reader.onerror = () => {
      reject(new Error('文件读取失败'));
    };
    
    reader.readAsDataURL(file);
  });
};
