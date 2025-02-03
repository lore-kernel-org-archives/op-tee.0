From: kernel test robot <lkp@intel.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 6/8] tee: add Qualcomm TEE driver
Date: Mon, 03 Feb 2025 20:44:41 +0800
Message-ID: <202502032035.o5DxD10H-lkp@intel.com>
In-Reply-To: <=?utf-8?q?=3C20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-?=
 =?utf-8?q?6-297eacd0d34f=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4766506273782932365=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============4766506273782932365==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Amirreza,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dab2734f8e9ecba609d66d1dd087a392a7774c04]

url:    https://github.com/intel-lab-lkp/linux/commits/Amirreza-Zarrabi/tee-a=
llow-a-driver-to-allocate-a-tee_device-without-a-pool/20250203-104846
base:   dab2734f8e9ecba609d66d1dd087a392a7774c04
patch link:    https://lore.kernel.org/r/20250202-qcom-tee-using-tee-ss-witho=
ut-mem-obj-v2-6-297eacd0d34f%40quicinc.com
patch subject: [PATCH v2 6/8] tee: add Qualcomm TEE driver
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20250203/2=
02502032035.o5DxD10H-lkp(a)intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archive/2=
0250203/202502032035.o5DxD10H-lkp(a)intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version =
of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502032035.o5DxD10H-lkp(a)i=
ntel.com/

All warnings (new ones prefixed by >>):

   drivers/tee/qcomtee/call.c: In function 'qcomtee_object_invoke':
   drivers/tee/qcomtee/call.c:419:16: error: cleanup argument not a function
     419 |         struct qcomtee_object_invoke_ctx *oic __free(kfree) =3D NU=
LL;
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/tee/qcomtee/call.c:421:16: error: cleanup argument not a function
     421 |         struct qcomtee_arg *u __free(kfree) =3D NULL;
         |                ^~~~~~~~~~~
   drivers/tee/qcomtee/call.c:439:15: error: implicit declaration of function=
 'kzalloc' [-Werror=3Dimplicit-function-declaration]
     439 |         oic =3D kzalloc(sizeof(*oic), GFP_KERNEL);
         |               ^~~~~~~
>> drivers/tee/qcomtee/call.c:439:13: warning: assignment to 'struct qcomtee_=
object_invoke_ctx *' from 'int' makes pointer from integer without a cast [-W=
int-conversion]
     439 |         oic =3D kzalloc(sizeof(*oic), GFP_KERNEL);
         |             ^
   drivers/tee/qcomtee/call.c:444:13: error: implicit declaration of function=
 'kcalloc' [-Werror=3Dimplicit-function-declaration]
     444 |         u =3D kcalloc(arg->num_params + 1, sizeof(*u), GFP_KERNEL);
         |             ^~~~~~~
>> drivers/tee/qcomtee/call.c:444:11: warning: assignment to 'struct qcomtee_=
arg *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     444 |         u =3D kcalloc(arg->num_params + 1, sizeof(*u), GFP_KERNEL);
         |           ^
   drivers/tee/qcomtee/call.c: In function 'qcomtee_open':
   drivers/tee/qcomtee/call.c:584:16: error: cleanup argument not a function
     584 |         struct qcomtee_context_data *ctxdata __free(kfree) =3D NUL=
L;
         |                ^~~~~~~~~~~~~~~~~~~~
>> drivers/tee/qcomtee/call.c:586:17: warning: assignment to 'struct qcomtee_=
context_data *' from 'int' makes pointer from integer without a cast [-Wint-c=
onversion]
     586 |         ctxdata =3D kzalloc(sizeof(*ctxdata), GFP_KERNEL);
         |                 ^
   drivers/tee/qcomtee/call.c: In function 'qcomtee_release':
   drivers/tee/qcomtee/call.c:623:9: error: implicit declaration of function =
'kfree' [-Werror=3Dimplicit-function-declaration]
     623 |         kfree(ctxdata);
         |         ^~~~~
   drivers/tee/qcomtee/call.c: In function 'qcomtee_probe':
   drivers/tee/qcomtee/call.c:655:16: error: cleanup argument not a function
     655 |         struct qcomtee *qcomtee __free(kfree) =3D NULL;
         |                ^~~~~~~
>> drivers/tee/qcomtee/call.c:659:17: warning: assignment to 'struct qcomtee =
*' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     659 |         qcomtee =3D kzalloc(sizeof(*qcomtee), GFP_KERNEL);
         |                 ^
   cc1: some warnings being treated as errors
--
   drivers/tee/qcomtee/core.c: In function 'qcomtee_object_alloc':
   drivers/tee/qcomtee/core.c:51:18: error: implicit declaration of function =
'kzalloc' [-Werror=3Dimplicit-function-declaration]
      51 |         object =3D kzalloc(sizeof(*object), GFP_KERNEL);
         |                  ^~~~~~~
>> drivers/tee/qcomtee/core.c:51:16: warning: assignment to 'struct qcomtee_o=
bject *' from 'int' makes pointer from integer without a cast [-Wint-conversi=
on]
      51 |         object =3D kzalloc(sizeof(*object), GFP_KERNEL);
         |                ^
   drivers/tee/qcomtee/core.c: In function 'qcomtee_object_free':
   drivers/tee/qcomtee/core.c:62:9: error: implicit declaration of function '=
kfree' [-Werror=3Dimplicit-function-declaration]
      62 |         kfree(object->name);
         |         ^~~~~
   drivers/tee/qcomtee/core.c: In function 'qcomtee_object_user_init':
   drivers/tee/qcomtee/core.c:249:17: warning: function 'qcomtee_object_user_=
init' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attri=
bute=3Dformat]
     249 |                 object->name =3D kvasprintf_const(GFP_KERNEL, fmt,=
 ap);
         |                 ^~~~~~
   drivers/tee/qcomtee/core.c: In function 'qcomtee_prepare_msg':
   drivers/tee/qcomtee/core.c:378:26: error: implicit declaration of function=
 'copy_from_user' [-Werror=3Dimplicit-function-declaration]
     378 |                 else if (copy_from_user(ptr, u[i].b.uaddr, u[i].b.=
size))
         |                          ^~~~~~~~~~~~~~
   drivers/tee/qcomtee/core.c: In function 'qcomtee_update_args':
   drivers/tee/qcomtee/core.c:458:26: error: implicit declaration of function=
 'copy_to_user' [-Werror=3Dimplicit-function-declaration]
     458 |                 else if (copy_to_user(u[i].b.uaddr, ptr, u[i].b.si=
ze))
         |                          ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/tee/qcomtee/user_obj.c: In function 'qcomtee_requests_destroy':
   drivers/tee/qcomtee/user_obj.c:238:25: error: implicit declaration of func=
tion 'kfree' [-Werror=3Dimplicit-function-declaration]
     238 |                         kfree(ureq);
         |                         ^~~~~
   drivers/tee/qcomtee/user_obj.c: In function 'qcomtee_user_object_dispatch':
   drivers/tee/qcomtee/user_obj.c:252:16: error: cleanup argument not a funct=
ion
     252 |         struct qcomtee_ureq *ureq __free(kfree) =3D NULL;
         |                ^~~~~~~~~~~~
   drivers/tee/qcomtee/user_obj.c:255:16: error: implicit declaration of func=
tion 'kzalloc' [-Werror=3Dimplicit-function-declaration]
     255 |         ureq =3D kzalloc(sizeof(*ureq), GFP_KERNEL);
         |                ^~~~~~~
>> drivers/tee/qcomtee/user_obj.c:255:14: warning: assignment to 'struct qcom=
tee_ureq *' from 'int' makes pointer from integer without a cast [-Wint-conve=
rsion]
     255 |         ureq =3D kzalloc(sizeof(*ureq), GFP_KERNEL);
         |              ^
   drivers/tee/qcomtee/user_obj.c: In function 'qcomtee_user_object_release':
   drivers/tee/qcomtee/user_obj.c:352:14: warning: assignment to 'struct qcom=
tee_ureq *' from 'int' makes pointer from integer without a cast [-Wint-conve=
rsion]
     352 |         ureq =3D kzalloc(sizeof(*ureq), GFP_KERNEL);
         |              ^
   drivers/tee/qcomtee/user_obj.c: In function 'qcomtee_user_param_to_object':
   drivers/tee/qcomtee/user_obj.c:394:16: error: cleanup argument not a funct=
ion
     394 |         struct qcomtee_user_object *user_object __free(kfree) =3D =
NULL;
         |                ^~~~~~~~~~~~~~~~~~~
>> drivers/tee/qcomtee/user_obj.c:398:21: warning: assignment to 'struct qcom=
tee_user_object *' from 'int' makes pointer from integer without a cast [-Win=
t-conversion]
     398 |         user_object =3D kzalloc(sizeof(*user_object), GFP_KERNEL);
         |                     ^
   drivers/tee/qcomtee/user_obj.c: In function 'qcomtee_cb_params_from_args':
   drivers/tee/qcomtee/user_obj.c:484:29: error: implicit declaration of func=
tion 'copy_to_user' [-Werror=3Dimplicit-function-declaration]
     484 |                         if (copy_to_user(params[i].u.ubuf.uaddr, u=
[i].b.addr,
         |                             ^~~~~~~~~~~~
   drivers/tee/qcomtee/user_obj.c: In function 'qcomtee_cb_params_to_args':
   drivers/tee/qcomtee/user_obj.c:561:29: error: implicit declaration of func=
tion 'copy_from_user' [-Werror=3Dimplicit-function-declaration]
     561 |                         if (copy_from_user(u[i].b.addr, params[i].=
u.ubuf.uaddr,
         |                             ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +439 drivers/tee/qcomtee/call.c

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
   421		struct qcomtee_arg *u __free(kfree) =3D NULL;
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
   602	/* This is called when the user closes the context. */
   603	static void qcomtee_close_context(struct tee_context *ctx)
   604	{
   605		struct qcomtee_context_data *ctxdata =3D ctx->data;
   606		struct qcomtee_object *object;
   607		int id;
   608=09
   609		/* Process QUEUED or PROCESSING requests. */
   610		qcomtee_requests_destroy(ctxdata);
   611		/* Release QTEE objects. */
   612		idr_for_each_entry(&ctxdata->qtee_objects_idr, object, id)
   613			qcomtee_object_put(object);
   614	}
   615=09
   616	/* This is called when the final reference to the context goes away. */
   617	static void qcomtee_release(struct tee_context *ctx)
   618	{
   619		struct qcomtee_context_data *ctxdata =3D ctx->data;
   620=09
   621		idr_destroy(&ctxdata->qtee_objects_idr);
   622		idr_destroy(&ctxdata->reqs_idr);
 > 623		kfree(ctxdata);
   624	}
   625=09

--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

--===============4766506273782932365==--

