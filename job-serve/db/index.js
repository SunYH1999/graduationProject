const {genUuid} = require('../utils');
const Sequelize = require('sequelize');

var sequelize = new Sequelize('mysql', 'root', '00000000', {
  pool: {
    max: 5,
    min: 0,
    idle: 10000
  },
  dialect: 'mysql'
});

sequelize
  .authenticate()
  .then(() => {
    console.log('Connection has been established successfully.');
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err);
  });

  /**
   * 用户
   * username 用户名
   * email 邮箱
   * mobile 手机号
   * password 密码
   * role 角色 1 求职者 2 应聘者 3 超级管理员
   */
const User = sequelize.define('user', {
  id: {
    type: Sequelize.UUID,
    primaryKey: true,
    defaultValue: () => {
      return genUuid()
    }
  },
  username : {
    type: Sequelize.STRING,
    allowNull: false,
    unique: true,
    validate: {
      isUnique: async (username) => { 
        const res = await User.findOne({where:{username}})
        if(res) throw new Error('用户名已存在');
      },
      notAllowNull(username) {
        if(!username) throw new Error('用户名不能为空');
      }
    }
  },
  email: {
    type: Sequelize.STRING,
    unique: true,
    validate: {
      isUnique: async (email) => { 
        const res = await User.findOne({where:{email}})
        if(res) throw new Error('邮箱已存在');
      },
      notAllowNull(email) {
        if(!email) throw new Error('邮箱不能为空');
      },
      isEmail: {
        msg: '邮箱格式不正确'
      }
    }
  },
  mobile: {
    type: Sequelize.STRING,
    allowNull: false,
    unique: true,
    validate: {
      isUnique: async (mobile) => { 
        const res = await User.findOne({where:{mobile}})
        if(res) throw new Error('手机号已存在');
      },
      notAllowNull(mobile) {
        if(!mobile) throw new Error('手机号不能为空');
      }
    }
  },
  password: {
    type: Sequelize.STRING,
    allowNull: false,
    validate: {
      notAllowNull(password) {
        if(!password) throw new Error('密码不能为空');
      }
    }
    
  },
  role: {
    type: Sequelize.INTEGER,
    defaultValue: 1,
    allowNull: false,
    validate: {
      notAllowNull(role) {
        if(!role) throw new Error('请选择注册角色');
      },
      notIn: {
        args: [1, 2],
        msg: '角色类型是数字(1, 2)'
      }
    }
  },
  token: {
    type: Sequelize.UUID
  }
});

  /**
   * 简历
   * name 姓名
   * sex 性别
   * year 出生年月
   * workYear 工作经验
   * address 现居地
   * mobile 手机号
   * email 邮箱
   * hope 求职意向
   * salary 期望薪资
   * work 工作经历
   * education 教育经历
   * personal 个人介绍
   */

  const Resume = sequelize.define('resume', {
    id: {
      type: Sequelize.UUID,
      primaryKey: true,
      defaultValue: () => {
        return genUuid()
      }
    },
    name : {
      type: Sequelize.STRING,
      allowNull: false,
      validate: {
        notAllowNull(name) {
          if(!name) throw new Error('姓名不能为空');
        }
      }
    },
    sex: {
      type: Sequelize.INTEGER,
      allowNull: false,
      validate: {
        notIn: {
          args: [0, 1],
          msg: '性别是数字(0, 1)'
        }
      }
    },
    year: {
      type: Sequelize.DATE,
      allowNull: false,
      validate: {
        isDate: {
          msg: '出生年月是一个日期'
        }
      }
    },
    address: {
      type: Sequelize.STRING
    },
    mobile: {
      type: Sequelize.STRING
    },
    email: {
      type: Sequelize.STRING
    },
    hope: {
      type: Sequelize.STRING
    },
    salary: {
      type: Sequelize.STRING,
    },
    work: {
      type: Sequelize.STRING,
    },
    workYear: {
      type: Sequelize.STRING,
    },
    education: {
      type: Sequelize.STRING,
    },
    personal: {
      type: Sequelize.STRING,
    }
  });


  /**
   * 公司
   * name 公司名
   * address 公司地点
   * capital 注册资金
   * charge 法人姓名
   * identification 法人身份证
   * status 状态
   */

  const Company = sequelize.define('company', {
    id: {
      type: Sequelize.UUID,
      primaryKey: true,
      defaultValue: () => {
        return genUuid()
      }
    },
    name : {
      type: Sequelize.STRING,
      allowNull: false,
    },
    address: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    capital: {
      type: Sequelize.INTEGER,
      allowNull: false,
    },
    charge: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    identification: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    status: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  });

  /**
   * 岗位类别
   * name 岗位类别名称
   */

  
  const Category = sequelize.define('category', {
    id: {
      type: Sequelize.UUID,
      primaryKey: true,
      defaultValue: () => {
        return genUuid()
      }
    },
    name : {
      type: Sequelize.STRING,
      allowNull: false,
    }
  });

  /**
   * 岗位
   * name 岗位名
   * category 岗位分类
   * workYear 工作经验
   * salary 薪资
   * number 人数
   * describe 岗位描述
   * condition 岗位要求
   */

  const Job = sequelize.define('job', {
    id: {
      type: Sequelize.UUID,
      primaryKey: true,
      defaultValue: () => {
        return genUuid()
      }
    },
    name : {
      type: Sequelize.STRING,
      allowNull: false,
    },
    workYear: {
      type: Sequelize.STRING,
    },
    salary: {
      type: Sequelize.STRING,
    },
    number: {
      type: Sequelize.INTEGER,
    },
    describe: {
      type: Sequelize.STRING,
    },
    condition: {
      type: Sequelize.STRING,
    }
  });


  const Jobing = sequelize.define('jobing', {
    id: {
      type: Sequelize.UUID,
      primaryKey: true,
      defaultValue: () => {
        return genUuid()
      }
    },
    status : {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: 0
    }
  });

// 关系
User.hasOne(Resume);
User.hasOne(Company);
User.hasOne(Job);
Category.hasMany(Job);
Resume.belongsTo(User);
Company.belongsTo(User);
Job.belongsTo(User);
Job.belongsTo(Category);
Job.belongsToMany(Resume, {'through': Jobing})
Resume.belongsToMany(Job, {'through': Jobing})
// User.sync({force: true})
// Resume.sync({force: true})
// Company.sync({force: true})
// Category.sync({force: true})
// Job.sync({force: true})
// Jobing.sync({force: true})


module.exports = {
  User,
  Resume,
  Company,
  Category,
  Job,
  Jobing
}

