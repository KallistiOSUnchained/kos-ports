# kos-ports ##version##
#
# scripts/download.mk
# Copyright (C) 2015, 2023 Lawrence Sebald
#

fetch:
	@if [ ! -d "dist" ] ; then \
		mkdir dist ; \
	fi

	@cd dist ; \
	for _file in ${DOWNLOAD_FILES}; do \
		if [ ! -f "$$_file" ] ; then \
			if [ -n "${DOWNLOAD_SITES}" ] ; then \
				for _site in ${DOWNLOAD_SITES}; do \
					echo "Fetching $$_file from $$_site ..." ; \
					file="$$_site/$$_file" ; \
					${FETCH_CMD} $$file ; \
					if [ "$$?" -eq 0 ] ; then \
						break; \
					fi ; \
				done ; \
			else \
				echo "Fetching $$_file from ${DOWNLOAD_SITE} ..." ; \
				file="${DOWNLOAD_SITE}/$$_file" ; \
				${FETCH_CMD} $$file ; \
			fi ; \
		fi ; \
	done

	@if [ -z "${DOWNLOAD_FILES}" ] ; then \
		cd dist ; \
		if [ -n "${GIT_REPOSITORY}" ] ; then \
			if [ ! -d "${PORTNAME}-${PORTVERSION}" ] ; then \
				echo "Fetching ${PORTNAME} from ${GIT_REPOSITORY} ..." ; \
				if [ -n "${GIT_TAG}" ] ; then \
				    git clone ${GIT_REPOSITORY} --branch ${GIT_TAG} --single-branch --depth 1 ${PORTNAME}-${PORTVERSION} ; \
				elif [ -n "${GIT_BRANCH}" ] ; then \
					git clone ${GIT_REPOSITORY} --branch ${GIT_BRANCH} --single-branch ${PORTNAME}-${PORTVERSION} ; \
				else \
					git clone ${GIT_REPOSITORY} ${PORTNAME}-${PORTVERSION} ; \
				fi ; \
			elif [ -z "${GIT_TAG}" ] ; then \
				echo "Updating ${PORTNAME} from ${GIT_REPOSITORY} ..." ; \
				cd ${PORTNAME}-${PORTVERSION} ; \
				git pull ; \
				cd .. ; \
			fi ; \
			if [ -z "${GIT_TAG}" -a -n "${GIT_CHANGESET}" ] ; then \
				cd ${PORTNAME}-${PORTVERSION} ; \
				git reset --hard ${GIT_CHANGESET} ; \
			fi ; \
		elif [ -n "${SVN_REPOSITORY}" ] ; then \
			if [ ! -d "${PORTNAME}-${PORTVERSION}" ] ; then \
				echo "Fetching ${PORTNAME} from ${SVN_REPOSITORY} ..." ; \
				if [ -n "${SVN_REVISION}" ] ; then \
					svn checkout ${SVN_REPOSITORY} -r ${SVN_REVISION} ${PORTNAME}-${PORTVERSION} ; \
				else \
					svn checkout ${SVN_REPOSITORY} ${PORTNAME}-${PORTVERSION} ; \
				fi ; \
			else \
				echo "Updating ${PORTNAME} from ${SVN_REPOSITORY} ..." ; \
				cd ${PORTNAME}-${PORTVERSION} ; \
				if [ -n "${SVN_REVISION}" ] ; then \
					svn update -r "${SVN_REVISION}" ; \
				else \
					svn update ; \
				fi ; \
			fi ; \
		fi ; \
	fi
