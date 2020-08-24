#!/bin/sh

CLEAN_DIRS_AND_FILES=`ls "${DISCUZ_INSTALL}"|grep -v "(\"${DISCUZ_DATA}\" \"${DISCUZ_CONFIG}\" \"${DISCUZ_UC_CLIENT}\" \"${DISCUZ_UC_SERVER}\")"`
rm -rf "${CLEAN_DIRS_AND_FILES}"

cd "${DISCUZ_PACKAGE}" && unzip -qo "${DISCUZ_PACKAGE_NAME}" -d "${DISCUZ_INSTALL}" && cd $OLDPWD

chmod -R a+w "${DISCUZ_DATA}" "${DISCUZ_CONFIG}" "${DISCUZ_UC_CLIENT}" "${DISCUZ_UC_SERVER}"

if [ -e "${DISCUZ_DATA}/install.lock" ];then
    mv "${DISCUZ_INSTALL}/install/index.php" "${DISCUZ_INSTALL}/install/index.php.bak"
else
    mv "${DISCUZ_INSTALL}/install/index.php.bak" "${DISCUZ_INSTALL}/install/index.php"
fi

docker-php-entrypoint "$@"
