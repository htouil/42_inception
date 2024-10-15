<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', $_SERVER['DB_NAME'] );

/** Database username */
define( 'DB_USER', $_SERVER['DB_USER_NAME'] );

/** Database password */
define( 'DB_PASSWORD', $_SERVER['DB_USER_PWD'] );

/** Database hostname */
define( 'DB_HOST', $_SERVER['DB_HOST'] );



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
define('AUTH_KEY',         'KIP|^C7|Bwd5>=yP V+]xbS-DZ[|3b@TJ3DVLZnia<WA4?vq6)tpxX`8?s1;Tu~C');
define('SECURE_AUTH_KEY',  '%<1U1p+{8Moo7(SzLC01dj.|[QPrevmL;/kc$B6;Srrs$-$I!|p7-LhAOQ8*#[BS');
define('LOGGED_IN_KEY',    '4d{mUgge`jkB(@T7Y&?-Fs^t?.L&2_7K7&;Y-gJ40-VKMf]B?*6xq|:=~Hv3oI9P');
define('NONCE_KEY',        '%8H.lp,41!t@PL/)mX %M>u9b^.-Bvyn_Oa?[0Uto8cR;&zn5X^&/.Yz0<26#i,-');
define('AUTH_SALT',        'Pn+xY0E/IH]Ex7-tT/hVG/&l}DmZ,}HP.p??_gdMAh>7Sgk.pl^A?kA1&xw$MWq%');
define('SECURE_AUTH_SALT', '7 uER-}A,KB(Pwz/%dm)k##/)Z.I|zbECRdm@ uUMw^{-Psc0o)+^/8*g5B9X8@7');
define('LOGGED_IN_SALT',   't`b/T:p-rQ6G+e|,?V+-H(D/-) +hzi}<fx>Oi1+A!7Jxl4z#0!,:A-mksCx |>|');
define('NONCE_SALT',       'r9q8zR(BXwH&5S^_Yz)_@KJ^%x7c)S6>uQrk_8[,G<U~r A<VQaqKUGMWLB;m#L@');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, DB tables names with $table_prefix are created.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */

$table_prefix = 'wp_';

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
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
