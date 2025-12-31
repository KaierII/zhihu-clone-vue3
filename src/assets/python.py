from PIL import Image
import numpy as np

# 打开图片
img = Image.open("logo.png")
img_array = np.array(img)

# 把白色背景（RGB接近255,255,255）设为透明
white_mask = (img_array[:, :, 0] > 240) & (img_array[:, :, 1] > 240) & (img_array[:, :, 2] > 240)
img_array[white_mask] = [0, 0, 0, 0]  # RGBA 的 A=0 表示透明

# 转为 RGBA 并保存
img_rgba = Image.fromarray(img_array, 'RGBA')
img_rgba.save("logo-transparent.png", "PNG")

print("✅ 白边已扣掉，透明版已保存为 logo-transparent.png")