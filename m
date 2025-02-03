From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 6/8] tee: add Qualcomm TEE driver
Date: Mon, 03 Feb 2025 18:39:39 +0800
Message-ID: <202502031838.MfZgQhYA-lkp@intel.com>
In-Reply-To: <=?utf-8?q?=3C20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-?=
 =?utf-8?q?6-297eacd0d34f=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1271988495579534002=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============1271988495579534002==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Amirreza,

kernel test robot noticed the following build errors:

[auto build test ERROR on dab2734f8e9ecba609d66d1dd087a392a7774c04]

url:    https://github.com/intel-lab-lkp/linux/commits/Amirreza-Zarrabi/tee-a=
llow-a-driver-to-allocate-a-tee_device-without-a-pool/20250203-104846
base:   dab2734f8e9ecba609d66d1dd087a392a7774c04
patch link:    https://lore.kernel.org/r/20250202-qcom-tee-using-tee-ss-witho=
ut-mem-obj-v2-6-297eacd0d34f%40quicinc.com
patch subject: [PATCH v2 6/8] tee: add Qualcomm TEE driver
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/2025020=
3/202502031838.MfZgQhYA-lkp(a)intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1e=
c4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0250203/202502031838.MfZgQhYA-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502031838.MfZgQhYA-lkp(a)i=
ntel.com/

All errors (new ones prefixed by >>):

>> drivers/tee/qcomtee/call.c:419:40: error: use of undeclared identifier '__=
free_kfree'; did you mean '__free_pages'?
     419 |         struct qcomtee_object_invoke_ctx *oic __free(kfree) =3D NU=
LL;
         |                                               ^
   include/linux/cleanup.h:200:33: note: expanded from macro '__free'
     200 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:41:1: note: expanded from here
      41 | __free_kfree
         | ^
   include/linux/gfp.h:359:13: note: '__free_pages' declared here
     359 | extern void __free_pages(struct page *page, unsigned int order);
         |             ^
>> drivers/tee/qcomtee/call.c:419:40: error: 'cleanup' function '__free_pages=
' must take 1 parameter
     419 |         struct qcomtee_object_invoke_ctx *oic __free(kfree) =3D NU=
LL;
         |                                               ^
   include/linux/cleanup.h:200:33: note: expanded from macro '__free'
     200 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:41:1: note: expanded from here
      41 | __free_kfree
         | ^
   drivers/tee/qcomtee/call.c:421:24: error: use of undeclared identifier '__=
free_kfree'; did you mean '__free_pages'?
     421 |         struct qcomtee_arg *u __free(kfree) =3D NULL;
         |                               ^
   include/linux/cleanup.h:200:33: note: expanded from macro '__free'
     200 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:42:1: note: expanded from here
      42 | __free_kfree
         | ^
   include/linux/gfp.h:359:13: note: '__free_pages' declared here
     359 | extern void __free_pages(struct page *page, unsigned int order);
         |             ^
   drivers/tee/qcomtee/call.c:421:24: error: 'cleanup' function '__free_pages=
' must take 1 parameter
     421 |         struct qcomtee_arg *u __free(kfree) =3D NULL;
         |                               ^
   include/linux/cleanup.h:200:33: note: expanded from macro '__free'
     200 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:42:1: note: expanded from here
      42 | __free_kfree
         | ^
>> drivers/tee/qcomtee/call.c:439:8: error: call to undeclared function 'kzal=
loc'; ISO C99 and later do not support implicit function declarations [-Wimpl=
icit-function-declaration]
     439 |         oic =3D kzalloc(sizeof(*oic), GFP_KERNEL);
         |               ^
>> drivers/tee/qcomtee/call.c:439:6: error: incompatible integer to pointer c=
onversion assigning to 'struct qcomtee_object_invoke_ctx *' from 'int' [-Wint=
-conversion]
     439 |         oic =3D kzalloc(sizeof(*oic), GFP_KERNEL);
         |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tee/qcomtee/call.c:444:6: error: call to undeclared function 'kcal=
loc'; ISO C99 and later do not support implicit function declarations [-Wimpl=
icit-function-declaration]
     444 |         u =3D kcalloc(arg->num_params + 1, sizeof(*u), GFP_KERNEL);
         |             ^
>> drivers/tee/qcomtee/call.c:444:4: error: incompatible integer to pointer c=
onversion assigning to 'struct qcomtee_arg *' from 'int' [-Wint-conversion]
     444 |         u =3D kcalloc(arg->num_params + 1, sizeof(*u), GFP_KERNEL);
         |           ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tee/qcomtee/call.c:584:39: error: use of undeclared identifier '__=
free_kfree'; did you mean '__free_pages'?
     584 |         struct qcomtee_context_data *ctxdata __free(kfree) =3D NUL=
L;
         |                                              ^
   include/linux/cleanup.h:200:33: note: expanded from macro '__free'
     200 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:51:1: note: expanded from here
      51 | __free_kfree
         | ^
   include/linux/gfp.h:359:13: note: '__free_pages' declared here
     359 | extern void __free_pages(struct page *page, unsigned int order);
         |             ^
   drivers/tee/qcomtee/call.c:584:39: error: 'cleanup' function '__free_pages=
' must take 1 parameter
     584 |         struct qcomtee_context_data *ctxdata __free(kfree) =3D NUL=
L;
         |                                              ^
   include/linux/cleanup.h:200:33: note: expanded from macro '__free'
     200 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:51:1: note: expanded from here
      51 | __free_kfree
         | ^
   drivers/tee/qcomtee/call.c:586:12: error: call to undeclared function 'kza=
lloc'; ISO C99 and later do not support implicit function declarations [-Wimp=
licit-function-declaration]
     586 |         ctxdata =3D kzalloc(sizeof(*ctxdata), GFP_KERNEL);
         |                   ^
>> drivers/tee/qcomtee/call.c:586:10: error: incompatible integer to pointer =
conversion assigning to 'struct qcomtee_context_data *' from 'int' [-Wint-con=
version]
     586 |         ctxdata =3D kzalloc(sizeof(*ctxdata), GFP_KERNEL);
         |                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tee/qcomtee/call.c:623:2: error: call to undeclared function 'kfre=
e'; ISO C99 and later do not support implicit function declarations [-Wimplic=
it-function-declaration]
     623 |         kfree(ctxdata);
         |         ^
   drivers/tee/qcomtee/call.c:655:26: error: use of undeclared identifier '__=
free_kfree'; did you mean '__free_pages'?
     655 |         struct qcomtee *qcomtee __free(kfree) =3D NULL;
         |                                 ^
   include/linux/cleanup.h:200:33: note: expanded from macro '__free'
     200 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:58:1: note: expanded from here
      58 | __free_kfree
         | ^
   include/linux/gfp.h:359:13: note: '__free_pages' declared here
     359 | extern void __free_pages(struct page *page, unsigned int order);
         |             ^
   drivers/tee/qcomtee/call.c:655:26: error: 'cleanup' function '__free_pages=
' must take 1 parameter
     655 |         struct qcomtee *qcomtee __free(kfree) =3D NULL;
         |                                 ^
   include/linux/cleanup.h:200:33: note: expanded from macro '__free'
     200 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:58:1: note: expanded from here
      58 | __free_kfree
         | ^
   drivers/tee/qcomtee/call.c:659:12: error: call to undeclared function 'kza=
lloc'; ISO C99 and later do not support implicit function declarations [-Wimp=
licit-function-declaration]
     659 |         qcomtee =3D kzalloc(sizeof(*qcomtee), GFP_KERNEL);
         |                   ^
>> drivers/tee/qcomtee/call.c:659:10: error: incompatible integer to pointer =
conversion assigning to 'struct qcomtee *' from 'int' [-Wint-conversion]
     659 |         qcomtee =3D kzalloc(sizeof(*qcomtee), GFP_KERNEL);
         |                 ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tee/qcomtee/call.c:721:2: error: call to undeclared function 'kfre=
e'; ISO C99 and later do not support implicit function declarations [-Wimplic=
it-function-declaration]
     721 |         kfree(qcomtee);
         |         ^
   18 errors generated.
--
>> drivers/tee/qcomtee/core.c:51:11: error: call to undeclared function 'kzal=
loc'; ISO C99 and later do not support implicit function declarations [-Wimpl=
icit-function-declaration]
      51 |         object =3D kzalloc(sizeof(*object), GFP_KERNEL);
         |                  ^
>> drivers/tee/qcomtee/core.c:51:9: error: incompatible integer to pointer co=
nversion assigning to 'struct qcomtee_object *' from 'int' [-Wint-conversion]
      51 |         object =3D kzalloc(sizeof(*object), GFP_KERNEL);
         |                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tee/qcomtee/core.c:62:2: error: call to undeclared function 'kfree=
'; ISO C99 and later do not support implicit function declarations [-Wimplici=
t-function-declaration]
      62 |         kfree(object->name);
         |         ^
>> drivers/tee/qcomtee/core.c:378:12: error: call to undeclared function 'cop=
y_from_user'; ISO C99 and later do not support implicit function declarations=
 [-Wimplicit-function-declaration]
     378 |                 else if (copy_from_user(ptr, u[i].b.uaddr, u[i].b.=
size))
         |                          ^
>> drivers/tee/qcomtee/core.c:458:12: error: call to undeclared function 'cop=
y_to_user'; ISO C99 and later do not support implicit function declarations [=
-Wimplicit-function-declaration]
     458 |                 else if (copy_to_user(u[i].b.uaddr, ptr, u[i].b.si=
ze))
         |                          ^
   5 errors generated.
--
>> drivers/tee/qcomtee/user_obj.c:238:4: error: call to undeclared function '=
kfree'; ISO C99 and later do not support implicit function declarations [-Wim=
plicit-function-declaration]
     238 |                         kfree(ureq);
         |                         ^
>> drivers/tee/qcomtee/user_obj.c:252:28: error: use of undeclared identifier=
 '__free_kfree'; did you mean '__free_pages'?
     252 |         struct qcomtee_ureq *ureq __free(kfree) =3D NULL;
         |                                   ^
   include/linux/cleanup.h:200:33: note: expanded from macro '__free'
     200 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:59:1: note: expanded from here
      59 | __free_kfree
         | ^
   include/linux/gfp.h:359:13: note: '__free_pages' declared here
     359 | extern void __free_pages(struct page *page, unsigned int order);
         |             ^
>> drivers/tee/qcomtee/user_obj.c:252:28: error: 'cleanup' function '__free_p=
ages' must take 1 parameter
     252 |         struct qcomtee_ureq *ureq __free(kfree) =3D NULL;
         |                                   ^
   include/linux/cleanup.h:200:33: note: expanded from macro '__free'
     200 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:59:1: note: expanded from here
      59 | __free_kfree
         | ^
>> drivers/tee/qcomtee/user_obj.c:255:9: error: call to undeclared function '=
kzalloc'; ISO C99 and later do not support implicit function declarations [-W=
implicit-function-declaration]
     255 |         ureq =3D kzalloc(sizeof(*ureq), GFP_KERNEL);
         |                ^
>> drivers/tee/qcomtee/user_obj.c:255:7: error: incompatible integer to point=
er conversion assigning to 'struct qcomtee_ureq *' from 'int' [-Wint-conversi=
on]
     255 |         ureq =3D kzalloc(sizeof(*ureq), GFP_KERNEL);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tee/qcomtee/user_obj.c:336:2: error: call to undeclared function '=
kfree'; ISO C99 and later do not support implicit function declarations [-Wim=
plicit-function-declaration]
     336 |         kfree(ureq);
         |         ^
   drivers/tee/qcomtee/user_obj.c:352:9: error: call to undeclared function '=
kzalloc'; ISO C99 and later do not support implicit function declarations [-W=
implicit-function-declaration]
     352 |         ureq =3D kzalloc(sizeof(*ureq), GFP_KERNEL);
         |                ^
   drivers/tee/qcomtee/user_obj.c:352:7: error: incompatible integer to point=
er conversion assigning to 'struct qcomtee_ureq *' from 'int' [-Wint-conversi=
on]
     352 |         ureq =3D kzalloc(sizeof(*ureq), GFP_KERNEL);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tee/qcomtee/user_obj.c:361:3: error: call to undeclared function '=
kfree'; ISO C99 and later do not support implicit function declarations [-Wim=
plicit-function-declaration]
     361 |                 kfree(ureq);
         |                 ^
   drivers/tee/qcomtee/user_obj.c:370:2: error: call to undeclared function '=
kfree'; ISO C99 and later do not support implicit function declarations [-Wim=
plicit-function-declaration]
     370 |         kfree(uo);
         |         ^
   drivers/tee/qcomtee/user_obj.c:394:42: error: use of undeclared identifier=
 '__free_kfree'; did you mean '__free_pages'?
     394 |         struct qcomtee_user_object *user_object __free(kfree) =3D =
NULL;
         |                                                 ^
   include/linux/cleanup.h:200:33: note: expanded from macro '__free'
     200 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:82:1: note: expanded from here
      82 | __free_kfree
         | ^
   include/linux/gfp.h:359:13: note: '__free_pages' declared here
     359 | extern void __free_pages(struct page *page, unsigned int order);
         |             ^
   drivers/tee/qcomtee/user_obj.c:394:42: error: 'cleanup' function '__free_p=
ages' must take 1 parameter
     394 |         struct qcomtee_user_object *user_object __free(kfree) =3D =
NULL;
         |                                                 ^
   include/linux/cleanup.h:200:33: note: expanded from macro '__free'
     200 | #define __free(_name)   __cleanup(__free_##_name)
         |                                   ^
   <scratch space>:82:1: note: expanded from here
      82 | __free_kfree
         | ^
   drivers/tee/qcomtee/user_obj.c:398:16: error: call to undeclared function =
'kzalloc'; ISO C99 and later do not support implicit function declarations [-=
Wimplicit-function-declaration]
     398 |         user_object =3D kzalloc(sizeof(*user_object), GFP_KERNEL);
         |                       ^
>> drivers/tee/qcomtee/user_obj.c:398:14: error: incompatible integer to poin=
ter conversion assigning to 'struct qcomtee_user_object *' from 'int' [-Wint-=
conversion]
     398 |         user_object =3D kzalloc(sizeof(*user_object), GFP_KERNEL);
         |                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tee/qcomtee/user_obj.c:484:8: error: call to undeclared function '=
copy_to_user'; ISO C99 and later do not support implicit function declaration=
s [-Wimplicit-function-declaration]
     484 |                         if (copy_to_user(params[i].u.ubuf.uaddr, u=
[i].b.addr,
         |                             ^
>> drivers/tee/qcomtee/user_obj.c:561:8: error: call to undeclared function '=
copy_from_user'; ISO C99 and later do not support implicit function declarati=
ons [-Wimplicit-function-declaration]
     561 |                         if (copy_from_user(u[i].b.addr, params[i].=
u.ubuf.uaddr,
         |                             ^
   drivers/tee/qcomtee/user_obj.c:672:3: error: call to undeclared function '=
kfree'; ISO C99 and later do not support implicit function declarations [-Wim=
plicit-function-declaration]
     672 |                 kfree(ureq);
         |                 ^
   17 errors generated.


vim +419 drivers/tee/qcomtee/call.c

   406=09
   407	/**
   408	 * qcomtee_object_invoke() - Invoke a QTEE object.
   409	 * @ctx: TEE context.
   410	 * @arg: ioctl arguments.
   411	 * @params: parameters for the object.
   412	 *
   413	 * Return: On success, returns 0; on failure, returns < 0.
   414	 */
   415	static int qcomtee_object_invoke(struct tee_context *ctx,
   416					 struct tee_ioctl_object_invoke_arg *arg,
   417					 struct tee_param *params)
   418	{
 > 419		struct qcomtee_object_invoke_ctx *oic __free(kfree) =3D NULL;
   420		struct qcomtee_context_data *ctxdata =3D ctx->data;
 > 421		struct qcomtee_arg *u __free(kfree) =3D NULL;
   422		struct qcomtee_object *object;
   423		int i, ret, result;
   424=09
   425		if (qcomtee_params_check(params, arg->num_params))
   426			return -EINVAL;
   427=09
   428		/* First, handle reserved operations: */
   429		if (arg->op =3D=3D QCOMTEE_OBJREF_OP_RELEASE) {
   430			del_qtee_object(arg->object, ctxdata);
   431=09
   432			return 0;
   433		} else if (arg->op > QCOMTEE_OBJREF_OP_MIN) {
   434			return -EINVAL;
   435		}
   436=09
   437		/* Otherwise, invoke a QTEE object: */
   438=09
 > 439		oic =3D kzalloc(sizeof(*oic), GFP_KERNEL);
   440		if (!oic)
   441			return -ENOMEM;
   442=09
   443		/* +1 for ending QCOMTEE_ARG_TYPE_INV. */
 > 444		u =3D kcalloc(arg->num_params + 1, sizeof(*u), GFP_KERNEL);
   445		if (!u)
   446			return -ENOMEM;
   447=09
   448		/* Get an object to invoke. */
   449		if (arg->object =3D=3D TEE_OBJREF_NULL) {
   450			/* Use ROOT if TEE_OBJREF_NULL is invoked. */
   451			if (qcomtee_root_object_check(arg->op, params, arg->num_params))
   452				return -EINVAL;
   453=09
   454			object =3D ROOT_QCOMTEE_OBJECT;
   455		} else if (find_qtee_object(&object, arg->object, ctxdata)) {
   456			return -EINVAL;
   457		}
   458=09
   459		ret =3D qcomtee_params_to_args(u, params, arg->num_params, ctx);
   460		if (ret)
   461			goto out;
   462=09
   463		ret =3D qcomtee_object_do_invoke(oic, object, arg->op, u, &result);
   464		if (ret) {
   465			qcomtee_arg_for_each_input_object(i, u) {
   466				qcomtee_user_object_set_notify(u[i].o, false);
   467				qcomtee_object_put(u[i].o);
   468			}
   469=09
   470			goto out;
   471		}
   472=09
   473		if (!result) {
   474			/* Assume service is UNAVAIL if unable to process the result. */
   475			if (qcomtee_params_from_args(params, u, arg->num_params, ctx))
   476				result =3D QCOMTEE_MSG_ERROR_UNAVAIL;
   477		} else {
   478			/*
   479			 * qcomtee_params_to_args() gets a copy of IO for the driver to
   480			 * make sure they do not get released while in the middle of
   481			 * invocation. On success (!result), qcomtee_params_from_args()
   482			 * puts them.
   483			 */
   484			qcomtee_arg_for_each_input_object(i, u)
   485				qcomtee_object_put(u[i].o);
   486		}
   487=09
   488		arg->ret =3D result;
   489	out:
   490		qcomtee_object_put(object);
   491=09
   492		return ret;
   493	}
   494=09
   495	/**
   496	 * qcomtee_supp_recv() - Wait for a request for the supplicant.
   497	 * @ctx: TEE context.
   498	 * @op: requested operation on the object.
   499	 * @num_params: number of elements in the parameter array.
   500	 * @params: parameters for @op.
   501	 *
   502	 * The first parameter is a meta %TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOU=
T.
   503	 * On input, it provides a user buffer. This buffer is used for parame=
ters of
   504	 * type %TEE_IOCTL_PARAM_ATTR_TYPE_UBUF_INPUT in qcomtee_cb_params_fro=
m_args().
   505	 * On output, the object ID and request ID are stored in the meta para=
meter.
   506	 *
   507	 * @num_params is updated to the number of parameters that actually ex=
ist
   508	 * in @params on return.
   509	 *
   510	 * Return: On success, returns 0; on failure, returns < 0.
   511	 */
   512	static int qcomtee_supp_recv(struct tee_context *ctx, u32 *op, u32 *nu=
m_params,
   513				     struct tee_param *params)
   514	{
   515		struct qcomtee_user_object_request_data data;
   516		void __user *uaddr;
   517		size_t ubuf_size;
   518		int i, ret;
   519=09
   520		if (!*num_params)
   521			return -EINVAL;
   522=09
   523		/* We expect the first parameter to be an INOUT + meta parameter. */
   524		if (params->attr !=3D
   525		    (TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_INOUT | TEE_IOCTL_PARAM_ATTR_MET=
A))
   526			return -EINVAL;
   527=09
   528		/* Other parameters are none. */
   529		for (i =3D 1; i < *num_params; i++)
   530			if (params[i].attr)
   531				return -EINVAL;
   532=09
   533		if (!IS_ALIGNED(params->u.value.a, 8))
   534			return -EINVAL;
   535=09
   536		/* User buffer and size from meta parameter. */
   537		uaddr =3D u64_to_user_ptr(params->u.value.a);
   538		ubuf_size =3D params->u.value.b;
   539		/* Process TEE parameters. +/-1 to ignore the meta parameter. */
   540		ret =3D qcomtee_user_object_select(ctx, params + 1, *num_params - 1,
   541						 uaddr, ubuf_size, &data);
   542		if (ret)
   543			return ret;
   544=09
   545		params->u.value.a =3D data.object_id;
   546		params->u.value.b =3D data.id;
   547		params->u.value.c =3D 0;
   548		*op =3D data.op;
   549		*num_params =3D data.np + 1;
   550=09
   551		return 0;
   552	}
   553=09
   554	/**
   555	 * qcomtee_supp_send() - Submit a response for a request.
   556	 * @ctx: TEE context.
   557	 * @errno: return value for the request.
   558	 * @num_params: number of elements in the parameter array.
   559	 * @params: returned parameters.
   560	 *
   561	 * The first parameter is a meta %TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTP=
UT.
   562	 * It specifies the request ID this response belongs to.
   563	 *
   564	 * Return: On success, returns 0; on failure, returns < 0.
   565	 */
   566	static int qcomtee_supp_send(struct tee_context *ctx, u32 errno, u32 n=
um_params,
   567				     struct tee_param *params)
   568	{
   569		if (!num_params)
   570			return -EINVAL;
   571=09
   572		/* We expect the first parameter to be an OUTPUT + meta parameter. */
   573		if (params->attr !=3D (TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT |
   574				     TEE_IOCTL_PARAM_ATTR_META))
   575			return -EINVAL;
   576=09
   577		/* Process TEE parameters. +/-1 to ignore the meta parameter. */
   578		return qcomtee_user_object_submit(ctx, params + 1, num_params - 1,
   579						  params->u.value.a, errno);
   580	}
   581=09
   582	static int qcomtee_open(struct tee_context *ctx)
   583	{
   584		struct qcomtee_context_data *ctxdata __free(kfree) =3D NULL;
   585=09
 > 586		ctxdata =3D kzalloc(sizeof(*ctxdata), GFP_KERNEL);
   587		if (!ctxdata)
   588			return -ENOMEM;
   589=09
   590		idr_init(&ctxdata->qtee_objects_idr);
   591		spin_lock_init(&ctxdata->qtee_lock);
   592		idr_init(&ctxdata->reqs_idr);
   593		INIT_LIST_HEAD(&ctxdata->reqs_list);
   594		mutex_init(&ctxdata->reqs_lock);
   595		init_completion(&ctxdata->req_c);
   596=09
   597		ctx->data =3D no_free_ptr(ctxdata);
   598=09
   599		return 0;
   600	}
   601=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============1271988495579534002==--

