From: Bagas Sanjaya <bagasdotme@gmail.com>
To: op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2 8/8] Documentation: tee: Add Qualcomm TEE driver
Date: Wed, 05 Feb 2025 09:40:59 +0700
Message-ID: <Z6LPu7WcRFnSCyAq@archie.me>
In-Reply-To: <=?utf-8?q?=3C20250202-qcom-tee-using-tee-ss-without-mem-obj-v2-?=
 =?utf-8?q?8-297eacd0d34f=40quicinc=2Ecom=3E?=>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3171924895564675572=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3171924895564675572==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2025 at 06:43:36PM -0800, Amirreza Zarrabi wrote:
> +The QTEE driver offers the qcomtee_object, which represents an object with=
in
              "... provides ..."
> +both QTEE and the kernel. To access any service in QTEE, a client needs to
> +invoke an instance of this object. Any structure intended to represent a s=
ervice
> +for export to QTEE should include an instance of qcomtee_object::

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--===============3171924895564675572==
Content-Type: application/pgp-signature
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"
MIME-Version: 1.0

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlIVUVBQllLQUIwV0lRU1NZUTZDeTdveUZO
Q0hyVUgydVlsSlZWRk9vd1VDWjZMUHN3QUtDUkQydVlsSlZWRk8KbzBLYkFQOUJqV2d0VFQ5RXJh
VmU4WlVtelo4TVFkNHd6emxvNG81Y2tDRmxlWjNtU2dFQXhJRUN3a3U1enFxaApVeVJFNEp5cE1W
Z2grNmVFRENqSkpFT003QlBGdmdZPQo9TWE4RQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============3171924895564675572==--

