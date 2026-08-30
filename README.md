# ML / MLE Study Dashboard — Cloud Sync

这是你的 9 周学习 Dashboard 云端版。

## 已有功能

- CS61B / CS229 / ML-PyTorch / LeetCode 独立状态
- CS229 与 ML/PyTorch 持续任务时间窗
- 自动 Backlog
- 连续打卡天数
- 每周完成率与学习时长统计
- 每日学习时长与备注
- 本地缓存
- **Supabase 登录 + 跨设备云同步**
- 登录后在另一台电脑打开同一网站、登录同一账号即可看到相同进度
- 切回网页或重新获得焦点时会检查其他设备的新进度

## 目录

```text
.
├── index.html
├── config.js
├── config.example.js
├── supabase.sql
└── README.md
```

## 1. 创建 Supabase 项目

1. 打开 Supabase 并创建一个 project。
2. 进入 **SQL Editor**。
3. 把 `supabase.sql` 全部复制进去运行。
4. 这会创建 `study_state` 表，并启用 Row Level Security (RLS)。

> RLS 很重要：它确保每个账号只能读写自己的学习进度。

## 2. 配置前端连接

在 Supabase 项目的 API 设置中找到：

- Project URL
- anon key 或 publishable key

然后编辑 `config.js`：

```js
window.STUDY_APP_CONFIG = {
  supabaseUrl: "https://xxxxx.supabase.co",
  supabaseKey: "你的 anon / publishable key"
};
```

### 安全说明

前端使用 **anon / publishable key** 是正常的，因为真正的数据权限由 RLS 控制。

**不要把 `service_role` key 放到 GitHub、网页或任何前端代码中。**

## 3. GitHub Pages

创建一个 repo，例如：

```text
ml-mle-study-dashboard
```

把这几个文件放到 repo 根目录，然后：

```bash
git add .
git commit -m "feat: add cloud study dashboard"
git push
```

GitHub：

1. `Settings`
2. `Pages`
3. `Build and deployment`
4. `Deploy from a branch`
5. Branch: `main`
6. Folder: `/ (root)`
7. Save

之后会得到类似：

```text
https://YOUR_USERNAME.github.io/ml-mle-study-dashboard/
```

## 4. Supabase Auth 建议设置

如果你保留 Email confirmation：

- 第一次注册后需要去邮箱点击确认链接。
- 建议在 Supabase Auth 的 URL Configuration 中把 Site URL 设置成你的 GitHub Pages 地址。

如果你只是个人使用，也可以在 Supabase Auth 设置里关闭 Email confirmation，注册后即可直接登录。

## 5. 跨设备使用

电脑 A：

1. 打开 Dashboard
2. 登录
3. 完成 CS229 / LeetCode / PyTorch 等任务并打卡
4. 页面会自动保存到 Supabase

电脑 B：

1. 打开同一个 GitHub Pages 地址
2. 登录同一个账号
3. 云端进度自动载入

## 6. 本机旧进度迁移

本版仍保留原来的 `localStorage` 作为本地缓存。

如果第一次登录时云端还是空的、但当前浏览器已有旧版本打卡数据，网页会自动把本机进度上传到云端。

## 数据模型

为了让你的个人项目尽量简单，目前只有一张表：

```text
study_state
├── user_id
├── state (JSONB)
└── updated_at
```

整个 Dashboard 状态作为一个 JSON 保存，因此不需要为每个任务单独建表，后续修改计划也比较容易。

## 后续可以继续升级

- 自动保存新一轮计划
- 多个 roadmap / semester
- GitHub OAuth 登录
- 手机 PWA
- 浏览器通知
- Supabase Realtime
- 更细的学习时长图表
