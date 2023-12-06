From: David Laight <David.Laight@ACULAB.COM>
To: op-tee@lists.trustedfirmware.org
Subject: 
 RE: [PATCH v4] tee: Use iov_iter to better support shared buffer registration
Date: Wed, 06 Dec 2023 11:39:01 +0000
Message-ID: <7582460ba52e413eaab26d37fb56beed@AcuMS.aculab.com>
In-Reply-To: <206b634d-1d10-4057-ad8d-93e29fda5d6e@kernel.dk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3849139709440786536=="
List-Id: <op-tee.lists.trustedfirmware.org>

--===============3849139709440786536==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> > As Jens Wiklander has proposed using iov_iter_ubuf() instead of
> > import_ubuf(), should I propose a patch updating import_ubuf() and
> > import_single_range()? Or would you prefer that we keep the functions
> > unchanged for the time being?
>=20
> Arguably it should be consistent with iovec imports, which return the
> length (or error). But it might be safer to just check access_ok()
> first and then truncate at least, vs what is there now.

Is the access_ok() check even needed when setting up an iov_iter?
It is always checked again when the actual copy is done.

I looked at this a while back and couldn't see any code paths that
relied on the early access_ok() check.
Maybe it is historic?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT=
, UK
Registration No: 1397386 (Wales)

--===============3849139709440786536==--

