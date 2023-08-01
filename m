From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v7 3/5] efi: Add tee-based EFI variable driver
Date: Tue, 01 Aug 2023 17:34:18 +0100
Message-ID: <20230801173418.00007337@Huawei.com>
In-Reply-To: <20230731065041.1447-4-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8882240911248322330=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============8882240911248322330==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 31 Jul 2023 15:50:38 +0900
Masahisa Kojima <masahisa.kojima@linaro.org> wrote:

> When the flash is not owned by the non-secure world, accessing the EFI
> variables is straightforward and done via EFI Runtime Variable Services.
> In this case, critical variables for system integrity and security
> are normally stored in the dedicated secure storage and only accessible
> from the secure world.
>=20
> On the other hand, the small embedded devices don't have the special
> dedicated secure storage. The eMMC device with an RPMB partition is
> becoming more common, we can use an RPMB partition to store the
> EFI Variables.
>=20
> The eMMC device is typically owned by the non-secure world(linux in
> this case). There is an existing solution utilizing eMMC RPMB partition
> for EFI Variables, it is implemented by interacting with
> TEE(OP-TEE in this case), StandaloneMM(as EFI Variable Service Pseudo TA),
> eMMC driver and tee-supplicant. The last piece is the tee-based
> variable access driver to interact with TEE and StandaloneMM.
>=20
> So let's add the kernel functions needed.
>=20
> This feature is implemented as a kernel module.
> StMM PTA has TA_FLAG_DEVICE_ENUM_SUPP flag when registered to OP-TEE
> so that this tee_stmm_efi module is probed after tee-supplicant starts,
> since "SetVariable" EFI Runtime Variable Service requires to
> interact with tee-supplicant.
>=20
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Co-developed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>

I was curious - so drive by review. Feel free to ignore :)
All general code readability stuff and a suggestion for the subsystem to
get rid of boilerplate (like most large subsystems did years ago!)

Jonathan


> diff --git a/drivers/firmware/efi/stmm/tee_stmm_efi.c b/drivers/firmware/ef=
i/stmm/tee_stmm_efi.c
> new file mode 100644
> index 000000000000..f6623171ae04
> --- /dev/null
> +++ b/drivers/firmware/efi/stmm/tee_stmm_efi.c

...

> +/**
> + * tee_mm_communicate() - Pass a buffer to StandaloneMM running in TEE
> + *
> + * @comm_buf:		locally allocated communication buffer
> + * @dsize:		buffer size
> + * Return:		status code
> + */
> +static efi_status_t tee_mm_communicate(void *comm_buf, size_t dsize)
> +{
> +	size_t buf_size;
> +	efi_status_t ret;
> +	struct efi_mm_communicate_header *mm_hdr;
> +	struct tee_ioctl_invoke_arg arg;
> +	struct tee_param param[4];
> +	struct tee_shm *shm =3D NULL;
> +	int rc;
> +
> +	if (!comm_buf)
> +		return EFI_INVALID_PARAMETER;
> +
> +	mm_hdr =3D (struct efi_mm_communicate_header *)comm_buf;
> +	buf_size =3D mm_hdr->message_len + sizeof(efi_guid_t) + sizeof(size_t);
> +
> +	if (dsize !=3D buf_size)
> +		return EFI_INVALID_PARAMETER;
> +
> +	shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, comm_buf, buf_size);
> +	if (IS_ERR(shm)) {
> +		dev_err(pvt_data.dev, "Unable to register shared memory\n");
> +		return EFI_UNSUPPORTED;
> +	}
> +
> +	memset(&arg, 0, sizeof(arg));
> +	arg.func =3D PTA_STMM_CMD_COMMUNICATE;
> +	arg.session =3D pvt_data.session;
> +	arg.num_params =3D 4;
> +
> +	memset(param, 0, sizeof(param));
> +	param[0].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT;
> +	param[0].u.memref.size =3D buf_size;
> +	param[0].u.memref.shm =3D shm;
> +	param[1].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_VALUE_OUTPUT;
> +	param[2].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> +	param[3].attr =3D TEE_IOCTL_PARAM_ATTR_TYPE_NONE;
> +
> +	rc =3D tee_client_invoke_func(pvt_data.ctx, &arg, param);
> +	tee_shm_free(shm);
> +
> +	if (rc < 0 || arg.ret !=3D 0) {
> +		dev_err(pvt_data.dev,
> +			"PTA_STMM_CMD_COMMUNICATE invoke error: 0x%x\n", arg.ret);
> +		return EFI_DEVICE_ERROR;
> +	}
> +
> +	switch (param[1].u.value.a) {
> +	case ARM_SVC_SPM_RET_SUCCESS:
> +		ret =3D EFI_SUCCESS;
> +		break;
> +
> +	case ARM_SVC_SPM_RET_INVALID_PARAMS:
> +		ret =3D EFI_INVALID_PARAMETER;
> +		break;
> +
> +	case ARM_SVC_SPM_RET_DENIED:
> +		ret =3D EFI_ACCESS_DENIED;
> +		break;
> +
> +	case ARM_SVC_SPM_RET_NO_MEMORY:
> +		ret =3D EFI_OUT_OF_RESOURCES;
> +		break;
> +
> +	default:
> +		ret =3D EFI_ACCESS_DENIED;
> +	}
> +
> +	return ret;

Direct returns both shorter and easier to review!

> +}
> +

Lots of similar stuff to below...


> +
> +static efi_status_t tee_get_variable(u16 *name, efi_guid_t *vendor,
> +				     u32 *attributes, unsigned long *data_size,
> +				     void *data)
> +{
> +	struct var_check_property var_property;
> +	struct smm_variable_access *var_acc;
> +	size_t payload_size;
> +	size_t name_size;
> +	size_t tmp_dsize;
> +	u8 *comm_buf =3D NULL;
> +	efi_status_t ret;
> +
> +	if (!name || !vendor || !data_size) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	name_size =3D (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
> +	if (name_size > max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/* Trim output buffer size */
> +	tmp_dsize =3D *data_size;
> +	if (name_size + tmp_dsize >
> +	    max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE) {
> +		tmp_dsize =3D max_payload_size - MM_VARIABLE_ACCESS_HEADER_SIZE -
> +			    name_size;
> +	}
> +
> +	/* Get communication buffer and initialize header */
> +	payload_size =3D MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + tmp_dsize;
> +	var_acc =3D setup_mm_hdr(&comm_buf, payload_size,
> +			       SMM_VARIABLE_FUNCTION_GET_VARIABLE, &ret);
> +	if (!comm_buf)
> +		goto out;
> +
> +	/* Fill in contents */
> +	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> +	var_acc->data_size =3D tmp_dsize;
> +	var_acc->name_size =3D name_size;
> +	var_acc->attr =3D attributes ? *attributes : 0;
> +	memcpy(var_acc->name, name, name_size);
> +
> +	/* Communicate */

Comment seems a bit obvious.  General rule, don't comment the obvious. It just
provides places where the comments might become wrong during future refactors.

> +	ret =3D mm_communicate(comm_buf, payload_size);
> +	if (ret =3D=3D EFI_SUCCESS || ret =3D=3D EFI_BUFFER_TOO_SMALL)
> +		/* Update with reported data size for trimmed case */
> +		*data_size =3D var_acc->data_size;
> +	if (ret !=3D EFI_SUCCESS)
> +		goto out;
> +
> +	ret =3D get_property_int(name, name_size, vendor, &var_property);
> +	if (ret !=3D EFI_SUCCESS)
> +		goto out;
> +
> +	if (attributes)
> +		*attributes =3D var_acc->attr;
> +
> +	if (data)
> +		memcpy(data, (u8 *)var_acc->name + var_acc->name_size,
> +		       var_acc->data_size);
> +	else
> +		ret =3D EFI_INVALID_PARAMETER;

Keep to a simple out of line error flow as it's more readable even when it
is a line or 2 more code.

	if (!data) {
		ret =3D EFI_INVALID_PARAMETER;
		goto out;
	}
	memcpy()...
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t tee_get_next_variable(unsigned long *name_size,
> +					  efi_char16_t *name, efi_guid_t *guid)
> +{
> +	struct smm_variable_getnext *var_getnext;
> +	size_t payload_size;
> +	size_t out_name_size;
> +	size_t in_name_size;
> +	u8 *comm_buf =3D NULL;
> +	efi_status_t ret;
> +
> +	if (!name_size || !name || !guid) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;

As below.  Direct returns make it clear nothing to do and generally
give easier code to review.

> +	}
> +
> +	out_name_size =3D *name_size;
> +	in_name_size =3D (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
> +
> +	if (out_name_size < in_name_size) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	if (in_name_size >
> +	    max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
> +	}
> +
> +	/* Trim output buffer size */
> +	if (out_name_size > max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE)
> +		out_name_size =3D
> +			max_payload_size - MM_VARIABLE_GET_NEXT_HEADER_SIZE;
> +
> +	payload_size =3D MM_VARIABLE_GET_NEXT_HEADER_SIZE + out_name_size;
> +	var_getnext =3D setup_mm_hdr(&comm_buf, payload_size,
> +				   SMM_VARIABLE_FUNCTION_GET_NEXT_VARIABLE_NAME,
> +				   &ret);
> +	if (!comm_buf)

As below (I'm reviewing up the code)

> +		goto out;
> +
> +	/* Fill in contents */
> +	memcpy(&var_getnext->guid, guid, sizeof(var_getnext->guid));
> +	var_getnext->name_size =3D out_name_size;
> +	memcpy(var_getnext->name, name, in_name_size);
> +	memset((u8 *)var_getnext->name + in_name_size, 0x0,
> +	       out_name_size - in_name_size);
> +
> +	/* Communicate */
> +	ret =3D mm_communicate(comm_buf, payload_size);
> +	if (ret =3D=3D EFI_SUCCESS || ret =3D=3D EFI_BUFFER_TOO_SMALL) {
> +		/* Update with reported data size for trimmed case */
> +		*name_size =3D var_getnext->name_size;
> +	}
> +	if (ret !=3D EFI_SUCCESS)
> +		goto out;
> +
> +	memcpy(guid, &var_getnext->guid, sizeof(*guid));
> +	memcpy(name, var_getnext->name, var_getnext->name_size);
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t tee_set_variable(efi_char16_t *name, efi_guid_t *vendo=
r,
> +				     u32 attributes, unsigned long data_size,
> +				     void *data)
> +{
> +	efi_status_t ret;
> +	struct var_check_property var_property;
> +	struct smm_variable_access *var_acc;
> +	size_t payload_size;
> +	size_t name_size;
> +	u8 *comm_buf =3D NULL;
> +
> +	if (!name || name[0] =3D=3D 0 || !vendor) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;

Nothing to do so why not return here?

> +	}
> +	if (data_size > 0 && !data) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;

Also return here?

> +	}
> +	/* Check payload size */
> +	name_size =3D (ucs2_strnlen(name, EFI_VAR_NAME_LEN) + 1) * sizeof(u16);
> +	payload_size =3D MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + data_size;
> +	if (payload_size > max_payload_size) {
> +		ret =3D EFI_INVALID_PARAMETER;
> +		goto out;
and here.

> +	}
> +
> +	/*
> +	 * Allocate the buffer early, before switching to RW (if needed)
> +	 * so we won't need to account for any failures in reading/setting
> +	 * the properties, if the allocation fails
> +	 */
> +	var_acc =3D setup_mm_hdr(&comm_buf, payload_size,
> +			       SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
> +	if (!comm_buf)

In this case still nothing to do. Return here - plus ideally check ret
rather than comm_buf so it's clear that an error is being returned without
us having to look in setup_mm_hdr()

> +		goto out;
> +
> +	/*
> +	 * The API has the ability to override RO flags. If no RO check was
> +	 * requested switch the variable to RW for the duration of this call
> +	 */
> +	ret =3D get_property_int(name, name_size, vendor, &var_property);
> +	if (ret !=3D EFI_SUCCESS) {
> +		dev_err(pvt_data.dev, "Getting variable property failed\n");
> +		goto out;
> +	}
> +
> +	if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY) {
> +		ret =3D EFI_WRITE_PROTECTED;
> +		goto out;
> +	}
> +
> +	/* Fill in contents */
> +	memcpy(&var_acc->guid, vendor, sizeof(var_acc->guid));
> +	var_acc->data_size =3D data_size;
> +	var_acc->name_size =3D name_size;
> +	var_acc->attr =3D attributes;
> +	memcpy(var_acc->name, name, name_size);
> +	memcpy((u8 *)var_acc->name + name_size, data, data_size);
> +

Not sure why 2 blank lines here. One probably fine.

> +
> +	/* Communicate */
> +	ret =3D mm_communicate(comm_buf, payload_size);
> +	dev_dbg(pvt_data.dev, "Set Variable %s %d %lx\n", __FILE__, __LINE__, ret=
);
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static efi_status_t tee_set_variable_nonblocking(efi_char16_t *name,
> +						 efi_guid_t *vendor,
> +						 u32 attributes,
> +						 unsigned long data_size,
> +						 void *data)
> +{
> +	return EFI_UNSUPPORTED;
> +}
> +
> +static efi_status_t tee_query_variable_info(u32 attributes,
> +					    u64 *max_variable_storage_size,
> +					    u64 *remain_variable_storage_size,
> +					    u64 *max_variable_size)
> +{
> +	struct smm_variable_query_info *mm_query_info;
> +	size_t payload_size;
> +	efi_status_t ret;
> +	u8 *comm_buf;
> +
> +	payload_size =3D sizeof(*mm_query_info);
> +	mm_query_info =3D setup_mm_hdr(&comm_buf, payload_size,
> +				SMM_VARIABLE_FUNCTION_QUERY_VARIABLE_INFO,
> +				&ret);
> +	if (!comm_buf)
> +		goto out;

if (!comm_buf) nothing to do (which is good as I'd not expect setup_mm_hdr
to have side effects if it fails.  So return ret.  Which is a little odd.
Can we just use ret as the check instead? That way it's clear the error retur=
ned
isn't an accidental success.

> +
> +	mm_query_info->attr =3D attributes;
> +	ret =3D mm_communicate(comm_buf, payload_size);
> +	if (ret !=3D EFI_SUCCESS)
> +		goto out;
> +	*max_variable_storage_size =3D mm_query_info->max_variable_storage;
> +	*remain_variable_storage_size =3D
> +		mm_query_info->remaining_variable_storage;
> +	*max_variable_size =3D mm_query_info->max_variable_size;
> +
> +out:
> +	kfree(comm_buf);
> +	return ret;
> +}
> +
> +static int tee_stmm_efi_probe(struct device *dev)
> +{
> +	struct tee_ioctl_open_session_arg sess_arg;
> +	efi_status_t ret;
> +	int rc;
> +
> +	/* Open context with TEE driver */
> +	pvt_data.ctx =3D tee_client_open_context(NULL, tee_ctx_match, NULL, NULL);
> +	if (IS_ERR(pvt_data.ctx))
> +		return -ENODEV;
> +
> +	/* Open session with StMM PTA */
> +	memset(&sess_arg, 0, sizeof(sess_arg));
> +	export_uuid(sess_arg.uuid, &tee_stmm_efi_id_table[0].uuid);
> +	rc =3D tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
> +	if ((rc < 0) || (sess_arg.ret !=3D 0)) {
> +		dev_err(dev, "tee_client_open_session failed, err: %x\n",
> +			sess_arg.ret);
> +		rc =3D -EINVAL;
> +		goto out_ctx;

Up to you, but I'd be tempted to take this all devm_ managed
via devm_add_action_or_reset() and suitable callbacks.

Marginal benefit in lines of code but makes it much harder to forget
to tidy something up in some future refactoring / reordering of code.

> +	}
> +	pvt_data.session =3D sess_arg.session;
> +	pvt_data.dev =3D dev;
> +
> +	ret =3D get_max_payload(&max_payload_size);
> +	if (ret !=3D EFI_SUCCESS) {
> +		rc =3D -EIO;
> +		goto out_sess;
> +	}
> +
> +	max_buffer_size =3D MM_COMMUNICATE_HEADER_SIZE +
> +			  MM_VARIABLE_COMMUNICATE_SIZE +
> +			  max_payload_size;
> +
> +	tee_efivar_ops.get_variable =3D tee_get_variable;
> +	tee_efivar_ops.get_next_variable =3D tee_get_next_variable;
> +	tee_efivar_ops.set_variable =3D tee_set_variable;
> +	tee_efivar_ops.set_variable_nonblocking =3D tee_set_variable_nonblocking;
> +	tee_efivar_ops.query_variable_store =3D efi_query_variable_store;
> +	tee_efivar_ops.query_variable_info =3D tee_query_variable_info;
> +
> +	efivars_generic_ops_unregister();
> +	pr_info("Use tee-based EFI runtime variable services\n");
> +	efivars_register(&tee_efivars, &tee_efivar_ops);
> +
> +	return 0;
> +
> +out_sess:
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session);
> +out_ctx:
> +	tee_client_close_context(pvt_data.ctx);
> +
> +	return rc;
> +}
> +
> +static int tee_stmm_efi_remove(struct device *dev)
> +{
> +	efivars_unregister(&tee_efivars);
> +	efivars_generic_ops_register();
> +
> +	tee_client_close_session(pvt_data.ctx, pvt_data.session);
> +	tee_client_close_context(pvt_data.ctx);
> +
> +	return 0;
> +}
> +
> +MODULE_DEVICE_TABLE(tee, tee_stmm_efi_id_table);
> +
> +static struct tee_client_driver tee_stmm_efi_driver =3D {
> +	.id_table	=3D tee_stmm_efi_id_table,
> +	.driver		=3D {
> +		.name		=3D "tee-stmm-efi",
> +		.bus		=3D &tee_bus_type,
> +		.probe		=3D tee_stmm_efi_probe,
> +		.remove		=3D tee_stmm_efi_remove,
> +	},
> +};
> +
> +static int __init tee_stmm_efi_mod_init(void)
> +{
> +	return driver_register(&tee_stmm_efi_driver.driver);
> +}
> +
> +static void __exit tee_stmm_efi_mod_exit(void)
> +{
> +	driver_unregister(&tee_stmm_efi_driver.driver);
> +}
> +
> +module_init(tee_stmm_efi_mod_init);
> +module_exit(tee_stmm_efi_mod_exit);

Looks like tee client drivers could benefit from a=20
#define module_tee_client_driver(__tee_client_driver)=20
similar to module_platform_driver() and similar.
=20
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Ilias Apalodimas <ilias.apalodimas@linaro.org>");
> +MODULE_AUTHOR("Masahisa Kojima <masahisa.kojima@linaro.org>");
> +MODULE_DESCRIPTION("TEE based EFI runtime variable service driver");


--===============8882240911248322330==--

