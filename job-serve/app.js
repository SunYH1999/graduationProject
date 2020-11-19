const Koa = require('koa');
const cors = require('koa2-cors');
const bodyParser = require('koa-bodyparser')
const logger = require('koa-logger')
const checkToken = require('./middleware/check-token')
const router = require('./router');

const app = new Koa();
// 白名单
const whiteList = ['/login', '/register']
app.use(cors())
app.use(logger())
app.use(bodyParser())
app.use(checkToken(whiteList));
app.use(router.routes());
app.use(router.allowedMethods());

app.listen(3013);
