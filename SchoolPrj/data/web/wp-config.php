<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'db_wordpress' );

/** Database username */
define( 'DB_USER', 'neila' );

/** Database password */
define( 'DB_PASSWORD', 'neila' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          '1QpVZo1Ub~U>C7F 2j`BAm8p)N{3cGc[:)ZFE[R60mnlWvEw-KdrO/#Yv4.8L bf' );
define( 'SECURE_AUTH_KEY',   '&_]0ImCVr8f|_&6@Nj;]F0J(AKB.8y)0@zv@r+#WPHk=IJL)CX.f$F3T}^RS;l ,' );
define( 'LOGGED_IN_KEY',     ' +;F15T=Ph[M{6JHUjKY6%L*R&1i|1>h#zw^(y!,6I -^Y`:mc6xT)`Ys8+[B!;X' );
define( 'NONCE_KEY',         'mUBV)/9BVTO{<O-,|twFwTcygm$7]rY8i(Q@q_egchV;}LEjblue;{nB{.9S2o~G' );
define( 'AUTH_SALT',         'c8K<dr!}2Eg!kfN.]hmM78wuOy]H.UJHm!28(}=W,hU,/,ehEF{-s!AGW,OnELM6' );
define( 'SECURE_AUTH_SALT',  '7gJPzU[FZ71AC<^17~0n0U!9DX=xVv&]Rwdp*!ggnI}67iZzH/8k4B~}C&h^ .-3' );
define( 'LOGGED_IN_SALT',    '<ER=eP.9hxEpCso.sN;xuVxFxmoGLk}kD>SHA(Z_Mk>cRI&T})!B9]v]&uh1*LbB' );
define( 'NONCE_SALT',        'D,<y]2+,:h?9p/^5:S.~+w4VQ3u^^8HkP0~/muQ==r>LVa:U*}7Oq&NDg4xP(Ef#' );
define( 'WP_CACHE_KEY_SALT', 'G:(KDM#Ny:n,^LD$?WY[q/4VX(ZTQ}q-Z4?c*z`sMP^2[rH*s0X:i.XN%Ymn1=!/' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';


/* Add any custom values between this line and the "stop editing" line. */



/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
if ( ! defined( 'WP_DEBUG' ) ) {
	define( 'WP_DEBUG', false );
}

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
