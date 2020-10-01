From: Elvira Khabirova <e.khabirova@omprussia.ru>
To: op-tee@lists.trustedfirmware.org
Subject: 
 Re: [PATCH v2] tee: add support for application-based session login methods
Date: Thu, 01 Oct 2020 12:58:10 +0300
Message-ID: <20201001125810.5ff84815@akathisia>
In-Reply-To: <20201001094758.GA928596@jade>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2993357068521737010=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============2993357068521737010==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Oct 2020 11:47:58 +0200
Jens Wiklander <jens.wiklander@linaro.org> wrote:

> On Wed, Sep 30, 2020 at 07:56:52PM +0300, Elvira Khabirova wrote:
> > +#if defined(CONFIG_TEE_APPID_PATH) || defined(CONFIG_TEE_APPID_SECURITY)
> > +static void free_app_id(void *data)
> > +{
> > +	kfree(data);
> > +}
> > +#endif /* CONFIG_TEE_APPID_PATH || CONFIG_TEE_APPID_SECURITY */
> I don't think we need this function, we could just as well use kfree()
> directly instead.

Ah, I supposed "use the pattern you're already using" meant to keep
the freeing function too. My bad.

> Thanks,
> Jens
>=20
> > +
> >  /**
> >   * uuid_v5() - Calculate UUIDv5
> >   * @uuid: Resulting UUID
> > @@ -208,6 +277,8 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 co=
nnection_method,
> >  	gid_t ns_grp =3D (gid_t)-1;
> >  	kgid_t grp =3D INVALID_GID;
> >  	char *name =3D NULL;
> > +	void *app_id_data =3D NULL;
> > +	const char *app_id =3D NULL;
> >  	int name_len;
> >  	int rc;
> > =20
> > @@ -228,6 +299,14 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 c=
onnection_method,
> >  	 * For TEEC_LOGIN_GROUP:
> >  	 * gid=3D<gid>
> >  	 *
> > +	 * For TEEC_LOGIN_APPLICATION:
> > +	 * app=3D<application id>
> > +	 *
> > +	 * For TEEC_LOGIN_USER_APPLICATION:
> > +	 * uid=3D<uid>:app=3D<application id>
> > +	 *
> > +	 * For TEEC_LOGIN_GROUP_APPLICATION:
> > +	 * gid=3D<gid>:app=3D<application id>
> >  	 */
> > =20
> >  	name =3D kzalloc(TEE_UUID_NS_NAME_SIZE, GFP_KERNEL);
> > @@ -238,10 +317,6 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 c=
onnection_method,
> >  	case TEE_IOCTL_LOGIN_USER:
> >  		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=3D%x",
> >  				    current_euid().val);
> > -		if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
> > -			rc =3D -E2BIG;
> > -			goto out_free_name;
> > -		}
> >  		break;
> > =20
> >  	case TEE_IOCTL_LOGIN_GROUP:
> > @@ -254,10 +329,49 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 =
connection_method,
> > =20
> >  		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=3D%x",
> >  				    grp.val);
> > -		if (name_len >=3D TEE_UUID_NS_NAME_SIZE) {
> > -			rc =3D -E2BIG;
> > +		break;
> > +
> > +	case TEE_IOCTL_LOGIN_APPLICATION:
> > +		app_id =3D get_app_id(&app_id_data);
> > +		if (IS_ERR(app_id)) {
> > +			rc =3D PTR_ERR(app_id);
> > +			goto out_free_name;
> > +		}
> > +
> > +		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "app=3D%s",
> > +				    app_id);
> > +		free_app_id(app_id_data);
> > +		break;
> > +
> > +	case TEE_IOCTL_LOGIN_USER_APPLICATION:
> > +		app_id =3D get_app_id(&app_id_data);
> > +		if (IS_ERR(app_id)) {
> > +			rc =3D PTR_ERR(app_id);
> > +			goto out_free_name;
> > +		}
> > +
> > +		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "uid=3D%x:app=3D%s",
> > +				    current_euid().val, app_id);
> > +		free_app_id(app_id_data);
> > +		break;
> > +
> > +	case TEE_IOCTL_LOGIN_GROUP_APPLICATION:
> > +		memcpy(&ns_grp, connection_data, sizeof(gid_t));
> > +		grp =3D make_kgid(current_user_ns(), ns_grp);
> > +		if (!gid_valid(grp) || !in_egroup_p(grp)) {
> > +			rc =3D -EPERM;
> > +			goto out_free_name;
> > +		}
> > +
> > +		app_id =3D get_app_id(&app_id_data);
> > +		if (IS_ERR(app_id)) {
> > +			rc =3D PTR_ERR(app_id);
> >  			goto out_free_name;
> >  		}
> > +
> > +		name_len =3D snprintf(name, TEE_UUID_NS_NAME_SIZE, "gid=3D%x:app=3D%s",
> > +				    grp.val, app_id);
> > +		free_app_id(app_id_data);
> >  		break;
> > =20
> >  	default:
> > @@ -265,7 +379,10 @@ int tee_session_calc_client_uuid(uuid_t *uuid, u32 c=
onnection_method,
> >  		goto out_free_name;
> >  	}
> > =20
> > -	rc =3D uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
> > +	if (name_len < TEE_UUID_NS_NAME_SIZE)
> > +		rc =3D uuid_v5(uuid, &tee_client_uuid_ns, name, name_len);
> > +	else
> > +		rc =3D -E2BIG;
> >  out_free_name:
> >  	kfree(name);
> > =20
> > --=20
> > 2.17.1
> >=20


--===============2993357068521737010==--

