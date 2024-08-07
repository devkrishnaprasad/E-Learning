PGDMP  -                     |            e_learning_app    16.1    16.0 %    I           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            J           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            K           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            L           1262    16554    e_learning_app    DATABASE     p   CREATE DATABASE e_learning_app WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';
    DROP DATABASE e_learning_app;
                postgres    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false            M           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    4            �            1259    16677    level_progress    TABLE     �   CREATE TABLE public.level_progress (
    level_id uuid NOT NULL,
    session_id uuid NOT NULL,
    username text NOT NULL,
    date_of_completion date NOT NULL,
    status boolean NOT NULL,
    product_id uuid NOT NULL
);
 "   DROP TABLE public.level_progress;
       public         heap    postgres    false    4            �            1259    16600    offer_banner_details    TABLE     6  CREATE TABLE public.offer_banner_details (
    banner_id uuid NOT NULL,
    amount text NOT NULL,
    title character varying(255) NOT NULL,
    description text NOT NULL,
    banner_image character varying(255),
    modified_date date NOT NULL,
    status boolean NOT NULL,
    modified_user text NOT NULL
);
 (   DROP TABLE public.offer_banner_details;
       public         heap    postgres    false    4            �            1259    16578    popular_products    TABLE     �   CREATE TABLE public.popular_products (
    item_id uuid NOT NULL,
    product_id uuid NOT NULL,
    last_modified date NOT NULL,
    last_modified_user text NOT NULL
);
 $   DROP TABLE public.popular_products;
       public         heap    postgres    false    4            �            1259    16564    product_category    TABLE     �   CREATE TABLE public.product_category (
    category_id uuid NOT NULL,
    category_name text NOT NULL,
    category_image text NOT NULL,
    username text NOT NULL,
    last_modified date NOT NULL,
    status boolean NOT NULL
);
 $   DROP TABLE public.product_category;
       public         heap    postgres    false    4            �            1259    16571    product_details    TABLE     
  CREATE TABLE public.product_details (
    product_id uuid NOT NULL,
    product_name text NOT NULL,
    product_image text NOT NULL,
    product_category text NOT NULL,
    price text NOT NULL,
    offer_price text NOT NULL,
    product_level text NOT NULL,
    rating text NOT NULL,
    students_count text NOT NULL,
    total_duration text NOT NULL,
    session_count text NOT NULL,
    about text NOT NULL,
    username text NOT NULL,
    last_modified date NOT NULL,
    status boolean NOT NULL,
    video_url text
);
 #   DROP TABLE public.product_details;
       public         heap    postgres    false    4            �            1259    16636    product_purchase_details    TABLE     �   CREATE TABLE public.product_purchase_details (
    product_id uuid NOT NULL,
    username text NOT NULL,
    purchased_date date NOT NULL,
    purchased_price text NOT NULL,
    purchase_id uuid NOT NULL,
    payment_method text NOT NULL
);
 ,   DROP TABLE public.product_purchase_details;
       public         heap    postgres    false    4            �            1259    16631    product_review    TABLE     �   CREATE TABLE public.product_review (
    review_id uuid NOT NULL,
    product_id uuid NOT NULL,
    rating text NOT NULL,
    no_of_likes text,
    review_description text NOT NULL,
    username text NOT NULL,
    last_modified date NOT NULL
);
 "   DROP TABLE public.product_review;
       public         heap    postgres    false    4            �            1259    16607    session_details    TABLE       CREATE TABLE public.session_details (
    session_id uuid NOT NULL,
    product_id uuid NOT NULL,
    session_title text NOT NULL,
    session_duration text NOT NULL,
    last_modified date NOT NULL,
    last_modified_user text NOT NULL,
    status boolean NOT NULL
);
 #   DROP TABLE public.session_details;
       public         heap    postgres    false    4            �            1259    16619    session_levels    TABLE     #  CREATE TABLE public.session_levels (
    level_id uuid NOT NULL,
    session_id uuid NOT NULL,
    video_path text NOT NULL,
    resourses text NOT NULL,
    level_title text NOT NULL,
    duration text NOT NULL,
    last_modified_date text NOT NULL,
    last_modified_user text NOT NULL
);
 "   DROP TABLE public.session_levels;
       public         heap    postgres    false    4            �            1259    16682    session_progress    TABLE     �   CREATE TABLE public.session_progress (
    session_id uuid NOT NULL,
    product_id uuid NOT NULL,
    username text NOT NULL,
    date_of_completion date NOT NULL,
    status boolean NOT NULL
);
 $   DROP TABLE public.session_progress;
       public         heap    postgres    false    4            �            1259    16642    user_details    TABLE     4  CREATE TABLE public.user_details (
    full_name character varying(50),
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    phone_number character varying(50),
    gender character varying(50),
    user_type character varying(50),
    profile_image character varying(50),
    date_of_birth date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_login timestamp without time zone,
    is_active boolean DEFAULT true
);
     DROP TABLE public.user_details;
       public         heap    postgres    false    4            E          0    16677    level_progress 
   TABLE DATA           p   COPY public.level_progress (level_id, session_id, username, date_of_completion, status, product_id) FROM stdin;
    public          postgres    false    224   �2       ?          0    16600    offer_banner_details 
   TABLE DATA           �   COPY public.offer_banner_details (banner_id, amount, title, description, banner_image, modified_date, status, modified_user) FROM stdin;
    public          postgres    false    218   3       >          0    16578    popular_products 
   TABLE DATA           b   COPY public.popular_products (item_id, product_id, last_modified, last_modified_user) FROM stdin;
    public          postgres    false    217   a4       <          0    16564    product_category 
   TABLE DATA           w   COPY public.product_category (category_id, category_name, category_image, username, last_modified, status) FROM stdin;
    public          postgres    false    215   6       =          0    16571    product_details 
   TABLE DATA           �   COPY public.product_details (product_id, product_name, product_image, product_category, price, offer_price, product_level, rating, students_count, total_duration, session_count, about, username, last_modified, status, video_url) FROM stdin;
    public          postgres    false    216   r8       C          0    16636    product_purchase_details 
   TABLE DATA           �   COPY public.product_purchase_details (product_id, username, purchased_date, purchased_price, purchase_id, payment_method) FROM stdin;
    public          postgres    false    222   U?       B          0    16631    product_review 
   TABLE DATA           �   COPY public.product_review (review_id, product_id, rating, no_of_likes, review_description, username, last_modified) FROM stdin;
    public          postgres    false    221   @       @          0    16607    session_details 
   TABLE DATA           �   COPY public.session_details (session_id, product_id, session_title, session_duration, last_modified, last_modified_user, status) FROM stdin;
    public          postgres    false    219   A       A          0    16619    session_levels 
   TABLE DATA           �   COPY public.session_levels (level_id, session_id, video_path, resourses, level_title, duration, last_modified_date, last_modified_user) FROM stdin;
    public          postgres    false    220   �B       F          0    16682    session_progress 
   TABLE DATA           h   COPY public.session_progress (session_id, product_id, username, date_of_completion, status) FROM stdin;
    public          postgres    false    225   7J       D          0    16642    user_details 
   TABLE DATA           �   COPY public.user_details (full_name, email, password_hash, phone_number, gender, user_type, profile_image, date_of_birth, created_at, updated_at, last_login, is_active) FROM stdin;
    public          postgres    false    223   TJ       �           2606    16606 .   offer_banner_details offer_banner_details_pkey 
   CONSTRAINT     s   ALTER TABLE ONLY public.offer_banner_details
    ADD CONSTRAINT offer_banner_details_pkey PRIMARY KEY (banner_id);
 X   ALTER TABLE ONLY public.offer_banner_details DROP CONSTRAINT offer_banner_details_pkey;
       public            postgres    false    218            �           2606    16570 &   product_category product_category_pkey 
   CONSTRAINT     m   ALTER TABLE ONLY public.product_category
    ADD CONSTRAINT product_category_pkey PRIMARY KEY (category_id);
 P   ALTER TABLE ONLY public.product_category DROP CONSTRAINT product_category_pkey;
       public            postgres    false    215            �           2606    16577 $   product_details product_details_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.product_details
    ADD CONSTRAINT product_details_pkey PRIMARY KEY (product_id);
 N   ALTER TABLE ONLY public.product_details DROP CONSTRAINT product_details_pkey;
       public            postgres    false    216            �           2606    16613 $   session_details session_details_pkey 
   CONSTRAINT     j   ALTER TABLE ONLY public.session_details
    ADD CONSTRAINT session_details_pkey PRIMARY KEY (session_id);
 N   ALTER TABLE ONLY public.session_details DROP CONSTRAINT session_details_pkey;
       public            postgres    false    219            �           2606    16625 "   session_levels session_levels_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.session_levels
    ADD CONSTRAINT session_levels_pkey PRIMARY KEY (level_id);
 L   ALTER TABLE ONLY public.session_levels DROP CONSTRAINT session_levels_pkey;
       public            postgres    false    220            �           2606    16665    user_details unique_email 
   CONSTRAINT     U   ALTER TABLE ONLY public.user_details
    ADD CONSTRAINT unique_email UNIQUE (email);
 C   ALTER TABLE ONLY public.user_details DROP CONSTRAINT unique_email;
       public            postgres    false    223            �           2606    16651 #   user_details user_details_email_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.user_details
    ADD CONSTRAINT user_details_email_key UNIQUE (email);
 M   ALTER TABLE ONLY public.user_details DROP CONSTRAINT user_details_email_key;
       public            postgres    false    223            �           2606    16614 /   session_details session_details_product_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.session_details
    ADD CONSTRAINT session_details_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.product_details(product_id) ON DELETE CASCADE;
 Y   ALTER TABLE ONLY public.session_details DROP CONSTRAINT session_details_product_id_fkey;
       public          postgres    false    219    216    3488            �           2606    16626 -   session_levels session_levels_session_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.session_levels
    ADD CONSTRAINT session_levels_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.session_details(session_id) ON DELETE CASCADE;
 W   ALTER TABLE ONLY public.session_levels DROP CONSTRAINT session_levels_session_id_fkey;
       public          postgres    false    219    3492    220            E      x������ � �      ?   ;  x����N�0E��+����vR�	�EL�BB��s�ڑ�������hW��_�{��Jc��TJ:	��Dǭ�v��l
����������H�ǡ���![���}�����(�"�S&�J��a8�'zwN�k��b;Mc��k��0�>l Ǳʲ�~ĀﹲqWG�)��R��^h�(�sI�8w�	�m������6��B�i��xK}�ft��q�t��a?�FJ�pҝ� HHPZqЭ`\Gf�Y���h�_lu�Ǟc��`��'�����[b�-KJr�3M���u�2�fh��n.���Hz�ʲ��괿      >   �  x���An]1 ��߅c�x׃t�n�&M�#��%Gx{��ad�ƛ�B�IL"�t��풉����	�i�f?iI��ҋ�P���������>���%�����?~������xD�1އ�%��g���`j~��##r� Vap���'���Ú�����l��ѱ���ܯv0�����b��=i���Xף�� %NaǁyH�ư�µ�\yaǄ��vc�k��R$�=l�9'��Zo�>Dv-�~eCF�ml�)��@�t�8��V?��'���|��F�lٔ�«�w͡�b]�,Xj��U�w�7�{�a�&4�ꪺ��������W��R�׵�Jro� �E�r������V-�]˦�J��Eb�����H_���IQ)�g��`�!��-�ϗ�����      <   P  x����nT1�קO1+v�&q�+��e��`�	9�3=�=3:3������������]�E�* &��&�P��Mx����|X����t~y}�p��.�r >��g���:.�����i=�G�|���>]�h�{� E2ĜjK��{!���O�a���绅O+�������I�W����Ԟ�\���*��2��"CT�QJ�ıUl�k���}�����e;�s�����͊j��KC�a0�-ظR�����nu}�R��ʮ�ӭ�g��ޒ�[�y(��	Z�Ѿ,ʨ|R5��K܂-��(༷���T+38,j	S��/����&X�g3،�A8.YF+ۤ�=V�$0�V��Jޅ���NǘEw����̗��$�s��6#k#�iD��O�2w��m!a/�����r�J4��B�(B���󛏻�!�w�X��)�3;m$:[���f�4eL)��P�(�\*�#�;̯��@/������ʧ�Y�}�B�s�0�Tmd��3u0�O�:p��Sg�&Ͷ�~d`���J#�����bV�ؽ9>.�ˣ�(�� �<&4���H$De�U_�WWW�����      =   �  x�ݘmo��_+���&hQ&�K޽9�I�+�Ĉ}(Pɡ��j)�츟�����M��w�l��g����G���.L����x�Zp�rr�
�G;�Z!�����l�{vT�a�a���l5�����-B�5ݒ�f���������e}��K��q�g��v80����T�:j�L�m�� �MX�b��t�T�Bʚk"����z4��z���3M���+!���~�`�e��d�!���v��i�������S3�؇�oY�nC�����ٜ_^����.c�l������}I8g�[�7G�D�����o�U�H�����.����ٔ?.,�j6>9��	�v #zm*�i��Z���b��{�s�8Set�:i:�$w�%�\Y��r��F��Y��Cŭ�k�̂[����e���#;젽�8��@�g��허-˥g��5t������CK\c��� (�aJ ��h_�r�����c��/>o��h"Hib�h �DŃ��+:x��z��W�4Q3}����	��"�.�9���m#N��8���a۴i��`X�}�k��_��[1�𿲲_r�e��7yA()��P"qok*eM���*!b�1����v�>�D	{ͮz�J�Ʀt��!`��q�4��+"�K��ڔ�R�z��
��O�����#-w.
�A�کG�����1�H�r�n��x�Y���۶�i�ݥ�U_�KR�mO����{R.��^���]j��B�������p�pQ�2T]�sE�kf�u����L���k�)�svI»����jn�I���v�g!������qJF��r��^�J$��^��@�kBI暃ĊDK�l�P�<*>g�������}Y3jG0�w;�%���u;>:d}�8����n��Ii�nKMt��NJ�&	z��8~A�����s+#�,�
�h]� ���R�Y5�Jkh���a�>�0���i?�����~��aI���]�=�AjRKBd^ٺ�dvR��b�-g1�
��$C�g�<��H��B�c�Lf��vl�S?����5�]Zуv�*cVeCl�-�"BiJ��i�p3�p����t'�
�,�Cb^7	b5�R%���T�f��4���j��㲦MY~�,������vUy�m�d+s��5��Ǉ��A(jS���\(�,E�s�u�wd�D����٤�NS�Brˠc4Z����!�9�,���`j�<�
Ɠ���$*����v˦��[zR�r�-���;�J��x�a�>�>]��BZ���s�����\� ~����A��Im�54�*e�Z�TIm+1ۏ!��G{j�8�_�.�������4h�헿>�HRzKZkG��Hy��2)�G������������������(�}����{q��N���(�*��lI���rp�4�]��\���w��;��/kԢ9�r�iȢ�"��]�f:/�4���z�U�ϛؗ��}ș���~J��i����4;�H����O�����>�aʐ�T�K]{W���ƝQ���<���Ւk8��,+#C����=j]��`o����ᚼ�N[�U30����s����~���}{T�yA�$)��t&�4y�d$(���	l�*�j=�*3G-v���s\�>_?Sm��wt�ҽ=���Y@��)&�����Z����Ɲ����JY994�D��t�s�@9��1Y��iד�e��7�`ms=}�C{�?�Ä<ކ�;>�����%	�?�^��7��
y      C   �   x���1n�0��Y���(i�A�P"�u���MQt����{�E�:�� � � �0�Qf!L�������w�����m������m��k"$��N�{�6����s��43���bĤ5���u[r��>��	����@�NU[��?��_���%rn��lVxep"�\E�p^�e���L^      B   �   x�Տ=n� �k|�w�}�?S�H���(�6�fQ��Jn|�t�o4�kf��h���rR�9��N����c�q�Z#�֡�0�����0��K��F�.g�v���R#�
���s�B^s���Wl'X�V�Ҡ�(�{�K�> ���p��i�Bz���?={�B#�O����}�To����M|R�N|PS?��!ZT�Ӿ��,���`���'/�0^Q��      @   �  x��ҽn�@���)�����L�������l��k'�۳	B��I�#��svF�a`��X
xj��S��Dm�	�p�21��Vc5�J���qٯk}(i��e���AÀH�o�i����k�R�����z��7w�4�7e��)gv�V��N!���Zţ�)����˿�q_�Ϛ�w�?��D��D�$�	��\�d!@���Īblͅ�PE3�w�9�̭bop��{����xm�;L�(D�H�Q!����c��x^��<��r��(V��O{(��Pt�a���VS���KMO�4o��.ղM��B2u���wm\��\zG�07�<�5IzfULo�q���mR��S����@:V�!� �fK�TD�JD5ի/xLu޶�͔�����<~Z���;}�����t���)R      A   e  x��YMo\�<�����M�9�$��Y� �6{ɥI6��J3��8N��SO�b��<2$A�����]]E�S��hԒ��Mj�B�z�n��L6�[�*�R�8�DMz�\��s�d�6/���~�3�5=n?���_������|��ǻ]������j��8���b�y��ĝ�0s�F<x�k$U�mƢ=F�����XkOsR�o�=�j5vj�c����|u?��G�5m������m�t�t:��6�m�L.��[�������>\o~>ݜ?���gW��e��{;��;��]��Ms��Ln`=��T�+�NI��:���
j�9�02��j�ԧBi��z�aS_�8���)�N^�P.J̕[V͵GP?�e�7�\�}w �7��;�o���_ ��έDV��0B"?u�HuF�4�3��i�S��S��iyH2��f��}���9q�-�h)#���j���Qi�:[�	��Ȯ
�\[%'
��u��z�"@�5W���ps������M�����s%��I�҅|���:�v;M�ϯȡ!p,�N7�Y�j�9�%�,AG�/d�YЍJ���w�u���͇PcA���vk����������￀3�)�����{�Rn8��@8S��.�8f�MH�OjK�zB�yr��Xb���꜉̙���&ȉISrd�y��9�[s�n��ⳑ/mO�cc��D}	�rr���|��lZ�Z�*�����S�5:��e\��{�~��~�3�қ	$[׎O�w6��0���1�0|�6<f�k�7A�@��2�8Ռ�� ��f�T��u���B%Zn�)��H��"	�2Еyha�`>������������ih< � �"J�e#�{�R�E���$ԙX��S�����i͉;lRf��<57��jl:&{l���!\Z�Y%	� ��hae(��߬>��������y{s��'����+�Di��jĤ\��h%��B��z���z�L`/���Cd�cB��[�9��\-/�����/�<Ʃ؃��͒�M���~������NO��ցXc3|LR� �AdWH *i4t��8����ة.J,/�U�Z����4O�R �K�!�{Bv��K� �u�����8�Y{DNkIu1@�vd��B���"��HE�x�3�]T;�`�;Q�U���<^"?o�֜��R$,����ZV�v��(�濁�Y��.&�H��0�Cѓ0r�q]�ר6m���).����K1}M�$e�`�;ă�c(���d{�Ό�7<��Ţw�'�{qQ�0�oІ�B�.��\��:��88[���[i��Y�#��=�;m?\N�����~|0n��\]�!C�PĄ�#YBv������i���A�E_��q�F�#\d�����	u�"��ɘa)Ǟ���|D��t��W��;\�3�5����w
��`�fo���@�l
�9*�n���?X�&!u1����O�&�enP �S���0<���	�[s�'��0؇��+rא1���L3���
���Cz�z���zu�R�������~!��q�-.�~AJ�o��3���;:���:;���v
�9���5E��׊$|�	�������{�4,ג�B¦�&�6���C��LS�O>c�������o�x���\n��	D�>���u�:X�z8�l.��)-��3��7a���Ʊc��j���l���Mۚw>q���`D5f4�԰�;�g��~�>_hAj�{ꋽE?z�F�ł���a�����o����t��V�8���S�����9<�T"-��C����x��n��kE��C��I9.�S	r6A�[�C���B�{,��"�=B<��e6�˜J�G1�s�t��e��w�ݾ�t���W��ϫ7o��Jm�      F      x������ � �      D      x�}�Ks�0��5�
nED�"�Z�U���1D�������qՎ�3gs����e�j����L.K۲��.�hT�Jo�׽�O:
�G� !��N٫�e�X���'�����i?�Ʌ�����a�z���"�a:-�a��~��*���=���Hr}�Z^�.���9\E�&���Cmu<�g+)��)�v����a�Q���$ĵ�r��k1;�D䬸�����o�a�~ȷ1Ff��-��B���NR���_]\�2��
O��p����v��5UU ��e     