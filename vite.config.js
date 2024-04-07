import { defineConfig } from "vite";
import { createVuePlugin } from "vite-plugin-vue2";
import path from "path";
import vitePluginRequire from "vite-plugin-require";
import vitePluginFileCopy from "vite-plugin-file-copy";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    createVuePlugin({
      template: {
        compilerOptions: {
          isCustomElement: (tag) => tag.includes("micro-app"),
        },
      },
    }),
    vitePluginRequire(),
    vitePluginFileCopy([
      {
        src: path.resolve(__dirname, "/statics/public"),
        dest: path.resolve(__dirname, "public"),
      },
    ]),
  ],
  css:{
    preprocessorOptions:{
      less:{
        javascriptEnabled: true, // 启用 Less 中的 JavaScript 表达式
      }
    }
  },
  base: "/", //打包路径
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"), //设置别名
      "~element-sea": path.resolve(__dirname, "node_modules/element-sea"),
      "~quill": path.resolve(__dirname, "node_modules/quill"),
      "~quill-mention-hi": path.resolve(
        __dirname,
        "node_modules/quill-mention-hi"
      ),
    },
    extensions: [".mjs", ".js", ".ts", ".jsx", ".tsx", ".json", ".vue"],
  },
  build: {
    manifest: true,
    outDir: "dist",
    assetsDir: "js/build",
    emptyOutDir: false,
    rollupOptions: {
      input: ["src/main.js", "index.html"],
      output: {
        manualChunks(id) {
          if (id.includes("node_modules")) {
            return id
              .toString()
              .split("node_modules/")[1]
              .split("/")[0]
              .toString();
          }
        },
      },
    },
    brotliSize: false,
    chunkSizeWarningLimit: 1500,
  },
  server: {
    port: 3000, //启动端口
    open: true,
    proxy: {
      "/request": {
        target: "http://82.157.62.190:8081",
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/request/, ""),
      },
    },
    cors: true,
  },
});
