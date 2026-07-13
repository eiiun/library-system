-- 为图书表添加简介字段并填充真实简介
-- 请在 Supabase SQL Editor 中执行此脚本

-- ============================================
-- 1. 添加 description 字段
-- ============================================
ALTER TABLE books ADD COLUMN IF NOT EXISTS description TEXT;

-- ============================================
-- 2. 更新原有5本编程类图书的简介
-- ============================================
UPDATE books SET description = 'JavaScript领域的经典之作，全面系统地介绍了JavaScript语言的核心概念、DOM操作、事件处理、Ajax技术等。适合有一定编程基础的读者深入理解JavaScript。' 
WHERE title = 'JavaScript高级程序设计';

UPDATE books SET description = '从程序员的视角深入理解计算机系统，涵盖数据表示、汇编语言、处理器体系结构、优化程序性能、存储器层次结构、链接、异常控制流、虚拟存储器、系统级I/O等内容。计算机专业必读经典。' 
WHERE title = '深入理解计算机系统';

UPDATE books SET description = '算法领域的圣经级著作，详细介绍了各种算法的设计与分析方法，包括排序、查找、图算法、动态规划、贪心算法等。配有大量习题和实际案例，是学习算法的必备参考书。' 
WHERE title = '算法导论';

UPDATE books SET description = '面向对象设计模式的开山之作，总结了23种经典设计模式，包括创建型、结构型和行为型模式。通过实际案例讲解如何运用设计模式提高软件的可复用性和可维护性。' 
WHERE title = '设计模式：可复用面向对象软件的基础';

UPDATE books SET description = '软件开发的百科全书，涵盖了变量命名、代码重构、测试、调试、性能优化等编程实践的方方面面。提供了大量实用的建议和最佳实践，帮助程序员写出高质量的代码。' 
WHERE title = '代码大全';

-- ============================================
-- 3. 计算机科学类（10本）
-- ============================================
UPDATE books SET description = 'Python入门经典教程，通过项目驱动的方式，从基础语法到Web开发、数据可视化、游戏开发等实际应用，循序渐进地带领读者掌握Python编程。' 
WHERE title = 'Python编程：从入门到实践';

UPDATE books SET description = 'Java领域权威教材，全面介绍Java语言特性、面向对象编程、异常处理、集合框架、I/O、并发编程、Swing GUI等内容。适合Java初学者和进阶开发者。' 
WHERE title = 'Java核心技术 卷I';

UPDATE books SET description = '系统讲解常用数据结构（链表、栈、队列、树、图等）和算法（排序、查找、哈希等）的设计与分析，强调理论与实践相结合，配有丰富的C++实现代码。' 
WHERE title = '数据结构与算法分析';

UPDATE books SET description = '采用自顶向下的方法讲解计算机网络，从应用层开始逐层向下，深入解析HTTP、DNS、TCP、IP等协议的工作原理和网络应用的开发技术。' 
WHERE title = '计算机网络：自顶向下方法';

UPDATE books SET description = '操作系统领域的经典教材，详细介绍进程管理、线程、CPU调度、内存管理、文件系统、I/O系统等核心概念，结合Linux和Windows实例讲解。' 
WHERE title = '操作系统概念';

UPDATE books SET description = '数据库系统权威指南，涵盖关系模型、SQL语言、数据库设计、事务管理、并发控制、恢复技术等核心内容，理论与实践并重。' 
WHERE title = '数据库系统概念';

UPDATE books SET description = '编译原理领域的经典著作，系统介绍词法分析、语法分析、语义分析、中间代码生成、代码优化和目标代码生成等编译器构造的核心技术。' 
WHERE title = '编译原理';

UPDATE books SET description = '人工智能领域的标准教材，全面介绍搜索算法、知识表示、机器学习、神经网络、自然语言处理、机器人学等AI核心技术和应用。' 
WHERE title = '人工智能：一种现代的方法';

UPDATE books SET description = '国内机器学习领域的权威著作，系统介绍决策树、神经网络、支持向量机、贝叶斯分类器、聚类、降维等主流机器学习算法的原理和应用。' 
WHERE title = '机器学习';

UPDATE books SET description = '深度学习领域的里程碑式著作，由三位先驱者撰写，全面介绍深度前馈网络、正则化、优化算法、卷积网络、循环网络、生成模型等核心技术。' 
WHERE title = '深度学习';

-- ============================================
-- 4. 文学类（8本）
-- ============================================
UPDATE books SET description = '中国古典小说巅峰之作，以贾宝玉、林黛玉、薛宝钗的爱情悲剧为主线，描绘了贾、史、王、薛四大家族的兴衰历程，展现了封建社会的全景画卷。' 
WHERE title = '红楼梦';

UPDATE books SET description = '中国四大名著之一，讲述唐僧师徒四人西天取经的神话故事，融合了佛教、道教文化，塑造了孙悟空、猪八戒等经典形象，充满奇幻色彩和人生哲理。' 
WHERE title = '西游记';

UPDATE books SET description = '中国历史演义小说的经典之作，描写了东汉末年到三国归晋近百年间的政治军事斗争，塑造了诸葛亮、曹操、关羽等众多英雄人物形象。' 
WHERE title = '三国演义';

UPDATE books SET description = '中国第一部歌颂农民起义的长篇章回体小说，讲述了北宋末年宋江等108位好汉在梁山泊聚义的故事，展现了官逼民反的社会现实。' 
WHERE title = '水浒传';

UPDATE books SET description = '余华代表作，通过主人公福贵一生的苦难经历，反映了中国近现代历史的变迁和人性的坚韧。文字朴实却震撼人心，被誉为"活着就是为了活着本身"。' 
WHERE title = '活着';

UPDATE books SET description = '路遥的代表作，以孙少安、孙少平两兄弟为中心，刻画了普通人在大时代历史进程中走过的艰难道路，展现了平凡人物的不平凡精神。' 
WHERE title = '平凡的世界';

UPDATE books SET description = '钱钟书的讽刺小说杰作，通过主人公方鸿渐的人生经历，揭示了知识分子的精神困境和社会的虚伪本质。"围城"已成为经典的文化符号。' 
WHERE title = '围城';

UPDATE books SET description = '陈忠实历时六年创作的史诗巨著，以陕西关中平原白鹿村为背景，描写了白姓和鹿姓两大家族祖孙三代的恩怨纷争，展现了半个多世纪的历史变迁。' 
WHERE title = '白鹿原';

-- ============================================
-- 5. 历史类（6本）
-- ============================================
UPDATE books SET description = '中国第一部纪传体通史，记载了从黄帝到汉武帝三千多年的历史，开创了纪传体史书体例，被鲁迅誉为"史家之绝唱，无韵之离骚"。' 
WHERE title = '史记';

UPDATE books SET description = '中国第一部编年体通史，由司马光主编，记载了从战国到五代共1362年的历史，以"鉴于往事，有资于治道"为宗旨，是研究中国古代历史的重要文献。' 
WHERE title = '资治通鉴';

UPDATE books SET description = '吕思勉先生的中国通史著作，以简洁明快的笔触梳理了中国从上古到近代的历史脉络，注重分析历史发展的规律和特点。' 
WHERE title = '中国通史';

UPDATE books SET description = '全球史观的代表作，突破传统西方中心论，从全球视角审视人类历史的发展，涵盖了各大文明的兴起、交流与碰撞。' 
WHERE title = '世界史';

UPDATE books SET description = '黄仁宇以大历史观解读明朝万历十五年（1587年）的历史细节，通过张居正、海瑞、戚继光等人物的命运，揭示了中国传统社会走向衰落的深层原因。' 
WHERE title = '万历十五年';

UPDATE books SET description = '贾雷德·戴蒙德从地理环境的角度解释人类社会的发展差异，探讨了为什么是欧亚大陆征服了美洲和非洲，而非相反。荣获普利策奖的经典之作。' 
WHERE title = '枪炮、病菌与钢铁';

-- ============================================
-- 6. 哲学类（5本）
-- ============================================
UPDATE books SET description = '罗素对西方哲学发展历程的系统梳理，从古希腊哲学到20世纪初的逻辑实证主义，以通俗易懂的语言介绍了各位哲学家的思想和贡献。' 
WHERE title = '西方哲学史';

UPDATE books SET description = '柏拉图的代表作，通过苏格拉底与他人对话的形式，探讨了正义、理想国家、教育、艺术等重大问题，是西方政治哲学的奠基之作。' 
WHERE title = '理想国';

UPDATE books SET description = '《论语》的现代注释本，杨伯峻先生对孔子及其弟子言行的精准翻译和详细注解，是学习和研究儒家思想的必备参考书。' 
WHERE title = '论语译注';

UPDATE books SET description = '道家创始人老子的哲学著作，仅五千言却蕴含深邃的智慧，阐述了"道"的本质、无为而治、柔弱胜刚强等核心思想，对中国文化影响深远。' 
WHERE title = '道德经';

UPDATE books SET description = '海德格尔的存在主义哲学巨著，探讨了"存在"的意义、时间性与存在的关系、人的生存状态等问题，是20世纪最重要的哲学著作之一。' 
WHERE title = '存在与时间';

-- ============================================
-- 7. 经济管理类（6本）
-- ============================================
UPDATE books SET description = '曼昆的经济学入门经典，以生动有趣的案例讲解微观经济学和宏观经济学的基本原理，包括供求理论、市场结构、国民收入、通货膨胀等核心概念。' 
WHERE title = '经济学原理';

UPDATE books SET description = '亚当·斯密的经济学奠基之作，系统阐述了自由市场经济的理论基础，提出了"看不见的手"的概念，被誉为"经济学圣经"。' 
WHERE title = '国富论';

UPDATE books SET description = '罗伯特·清崎通过两个爸爸的不同理财观念，揭示了财商教育的重要性，教导读者如何通过投资、创业等方式实现财务自由。' 
WHERE title = '穷爸爸富爸爸';

UPDATE books SET description = '桥水基金创始人瑞·达利欧分享其生活和工作原则，包括极度透明、极度真实、创意择优等理念，以及五步流程法等实用工具。' 
WHERE title = '原则';

UPDATE books SET description = '诺贝尔经济学奖得主丹尼尔·卡尼曼揭示人类思维的两种模式：快速直觉的系统1和缓慢理性的系统2，解释了认知偏差和决策失误的心理机制。' 
WHERE title = '思考，快与慢';

UPDATE books SET description = '心理学家罗伯特·西奥迪尼总结的六大影响力原则：互惠、承诺一致、社会认同、喜好、权威、稀缺，帮助读者识别和应对他人的影响策略。' 
WHERE title = '影响力';

-- ============================================
-- 8. 心理学类（4本）
-- ============================================
UPDATE books SET description = '心理学入门经典教材，全面介绍心理学的研究领域和方法，包括生物心理学、感觉与知觉、学习、记忆、思维、智力、情绪、人格、心理障碍等内容。' 
WHERE title = '心理学与生活';

UPDATE books SET description = '岸见一郎解读阿德勒心理学，提出"被讨厌的勇气"这一核心理念，鼓励读者摆脱他人期待，活出真正的自我，获得心灵自由。' 
WHERE title = '被讨厌的勇气';

UPDATE books SET description = '个体心理学创始人阿德勒的经典著作，分析了自卑感的来源和补偿机制，提出追求优越的目标，鼓励读者通过合作和社会兴趣超越自卑。' 
WHERE title = '自卑与超越';

UPDATE books SET description = '马歇尔·卢森堡提出的沟通方法，通过观察、感受、需要、请求四个要素，帮助人们在诚实和倾听的基础上与人建立真诚的连接。' 
WHERE title = '非暴力沟通';

-- ============================================
-- 9. 艺术设计类（5本）
-- ============================================
UPDATE books SET description = '诺曼从认知心理学角度分析日常用品的设计，提出了示能、意符、映射、反馈等设计原则，强调以用户为中心的设计理念。' 
WHERE title = '设计心理学';

UPDATE books SET description = '设计师Robin Williams总结的四大设计基本原则：对比、重复、对齐、亲密性，通过大量实例讲解如何提升文档、演示文稿、网页等的视觉效果。' 
WHERE title = '写给大家看的设计书';

UPDATE books SET description = '日本设计师团队编写的色彩设计指南，系统介绍色彩基础知识、配色技巧、色彩心理学以及在平面设计、产品设计中的实际应用。' 
WHERE title = '色彩设计的原理';

UPDATE books SET description = '佐佐木刚士讲解版式设计的基本原则和技巧，包括网格系统、字体选择、图文搭配、视觉流程等内容，配有大量优秀设计案例分析。' 
WHERE title = '版式设计原理';

UPDATE books SET description = '贡布里希的艺术史经典，从史前艺术到现代艺术，以生动的叙述方式梳理了西方艺术的发展脉络，被誉为"艺术史的入门圣经"。' 
WHERE title = '艺术的故事';

-- ============================================
-- 10. 科普类（6本）
-- ============================================
UPDATE books SET description = '霍金向大众普及宇宙学知识的经典之作，用通俗语言讲解了宇宙的起源、黑洞、时间箭头、统一理论等前沿科学问题，激发了无数人对科学的兴趣。' 
WHERE title = '时间简史';

UPDATE books SET description = '霍金的另一部科普力作，以更简洁的方式回答关于宇宙的十个重大问题，包括宇宙如何开端、时间的性质、多重宇宙等话题。' 
WHERE title = '宇宙简史';

UPDATE books SET description = '比尔·布莱森以幽默风趣的笔调讲述科学史上的重大发现和科学家们的趣事，从宇宙大爆炸到人类文明，让科学知识变得生动有趣。' 
WHERE title = '万物简史';

UPDATE books SET description = '达尔文的进化论奠基之作，通过大量观察证据论证了物种通过自然选择进化的理论，彻底改变了人类对生命起源和发展的认识。' 
WHERE title = '物种起源';

UPDATE books SET description = '理查德·道金斯从基因视角重新审视生物进化，提出"自私的基因"理论，解释了利他行为、亲缘选择等现象，引发了广泛讨论。' 
WHERE title = '自私的基因';

UPDATE books SET description = '尤瓦尔·赫拉利以宏大的视角回顾智人从石器时代到21世纪的演化历程，探讨了认知革命、农业革命、科学革命对人类社会的深刻影响。' 
WHERE title = '人类简史';

-- ============================================
-- 11. 外语学习类（4本）
-- ============================================
UPDATE books SET description = '经典的英语自学教材，采用独特的双语对照和螺旋式上升的教学方法，从基础发音到复杂语法，循序渐进地培养听、说、读、写能力。' 
WHERE title = '新概念英语1';

UPDATE books SET description = '剑桥大学考试委员会官方出版的雅思真题集，包含完整的听力、阅读、写作、口语试题及参考答案，是备考雅思的必备资料。' 
WHERE title = '剑桥雅思官方真题集';

UPDATE books SET description = '中日合作编写的日语入门教材，系统讲解五十音图、基础语法、日常会话等内容，配有丰富的练习和文化背景介绍，适合零基础学习者。' 
WHERE title = '日语初级教程';

UPDATE books SET description = '马晓宏编写的法语入门教材，从字母发音开始，逐步引入基础语法、词汇和日常表达，注重听说读写全面发展，适合法语初学者。' 
WHERE title = '法语入门';

-- ============================================
-- 12. 儿童读物类（5本）
-- ============================================
UPDATE books SET description = '丹麦作家安徒生创作的童话集，包括《丑小鸭》《卖火柴的小女孩》《海的女儿》等经典故事，充满想象力和人文关怀，适合儿童阅读。' 
WHERE title = '安徒生童话';

UPDATE books SET description = '格林兄弟收集的德国民间故事集，包括《白雪公主》《灰姑娘》《小红帽》等著名童话，是世界儿童文学的经典之作。' 
WHERE title = '格林童话';

UPDATE books SET description = '法国作家圣埃克苏佩里的哲理童话，通过小王子在不同星球的旅行经历，探讨了爱、责任、孤独、成长等永恒主题，适合所有年龄段的读者。' 
WHERE title = '小王子';

UPDATE books SET description = 'E.B.怀特的经典儿童文学作品，讲述了小猪威尔伯和蜘蛛夏洛之间真挚的友谊故事，探讨了生命、友情、牺牲等深刻主题。' 
WHERE title = '夏洛的网';

UPDATE books SET description = 'J.K.罗琳创作的魔法世界系列第一部，讲述了孤儿哈利·波特进入霍格沃茨魔法学校学习魔法、结交朋友、对抗黑魔王的冒险故事。' 
WHERE title = '哈利·波特与魔法石';

-- ============================================
-- 验证结果
-- ============================================
SELECT id, title, LENGTH(description) as desc_length 
FROM books 
WHERE description IS NOT NULL 
ORDER BY id;

SELECT '已添加简介的图书数量' as description, COUNT(*) as count 
FROM books 
WHERE description IS NOT NULL;
