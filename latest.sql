--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_polls = warning;

SET search_path = public, pg_catalog;

DROP INDEX public.unique_schema_migrations;
DROP INDEX public.index_users_on_reset_password_token;
DROP INDEX public.index_users_on_email;
ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
ALTER TABLE ONLY public.polls DROP CONSTRAINT polls_pkey;
ALTER TABLE ONLY public.images DROP CONSTRAINT images_pkey;
ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.polls ALTER COLUMN id DROP DEFAULT;
ALTER TABLE public.images ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE public.users_id_seq;
DROP TABLE public.users;
DROP TABLE public.schema_migrations;
DROP SEQUENCE public.polls_id_seq;
DROP TABLE public.polls;
DROP SEQUENCE public.images_id_seq;
DROP TABLE public.images;
DROP EXTENSION plpgsql;
DROP SCHEMA public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE images (
    id integer NOT NULL,
    s3_image_loc character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    image_processed boolean,
    bs_field character varying(255)
);


--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE images_id_seq OWNED BY images.id;


--
-- Name: polls; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE polls (
    id integer NOT NULL,
    question character varying(255),
    button1 character varying(255),
    button2 character varying(255),
    origin_poll integer,
    address character varying(255),
    response1 character varying(255),
    response2 character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status character varying(255),
    image_id integer,
    user_id integer,
    identifier character varying(255)
);


--
-- Name: polls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE polls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: polls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE polls_id_seq OWNED BY polls.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY images ALTER COLUMN id SET DEFAULT nextval('images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY polls ALTER COLUMN id SET DEFAULT nextval('polls_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: images; Type: TABLE DATA; Schema: public; Owner: -
--

COPY images (id, s3_image_loc, created_at, updated_at, image_processed, bs_field) FROM stdin;
1	\N	2014-01-15 23:02:38.993316	2014-01-15 23:02:38.993316	\N	\N
2	\N	2014-01-15 23:02:45.208155	2014-01-15 23:02:45.208155	\N	\N
3	gerard.jpg	2014-01-15 23:03:03.282185	2014-01-15 23:03:03.282185	\N	\N
4	gerard.jpg	2014-01-15 23:29:22.914509	2014-01-15 23:29:22.914509	\N	\N
5	image.jpg	2014-01-15 23:29:34.55315	2014-01-15 23:29:34.55315	\N	\N
6	image.jpg	2014-01-16 00:58:06.43621	2014-01-16 00:58:06.43621	\N	\N
7	image.jpg	2014-01-16 18:15:19.409473	2014-01-16 18:15:19.409473	\N	\N
8	image.jpg	2014-01-16 20:40:57.095276	2014-01-16 20:40:57.095276	\N	\N
9	image.jpg	2014-01-16 21:34:07.090866	2014-01-16 21:34:07.090866	\N	\N
10	gerard.jpg	2014-01-16 21:36:44.263769	2014-01-16 21:36:44.263769	\N	\N
11	image.jpg	2014-01-16 21:45:40.345003	2014-01-16 21:45:40.345003	\N	\N
12	image.jpg	2014-01-16 21:55:06.782869	2014-01-16 21:55:06.782869	\N	\N
13	meetup.JPG	2014-01-16 23:00:53.743929	2014-01-16 23:00:53.743929	\N	\N
14	image.jpg	2014-01-17 00:35:54.980206	2014-01-17 00:35:54.980206	\N	\N
15	PaperCamera2013-01-08-22-13-22.jpg	2014-01-17 05:40:40.218031	2014-01-17 05:40:40.218031	\N	\N
16	image.jpg	2014-01-17 19:24:47.731277	2014-01-17 19:24:47.731277	\N	\N
17	image.jpg	2014-01-17 20:33:33.693607	2014-01-17 20:33:33.693607	\N	\N
18	meetup.JPG	2014-01-17 20:49:11.700078	2014-01-17 20:49:11.700078	\N	\N
19	gerard.jpg	2014-01-17 21:41:49.195708	2014-01-17 21:41:49.195708	\N	\N
20	image.jpg	2014-01-17 22:33:15.079735	2014-01-17 22:33:15.079735	\N	\N
21	image.jpg	2014-01-17 22:45:17.750508	2014-01-17 22:45:17.750508	\N	\N
22	image.jpg	2014-01-17 22:50:56.006768	2014-01-17 22:50:56.006768	\N	\N
24	\N	2014-01-22 03:25:36.285128	2014-01-22 03:25:36.285128	\N	\N
25	\N	2014-01-22 04:47:44.310103	2014-01-22 04:47:44.310103	\N	\N
26	\N	2014-01-22 05:09:50.205472	2014-01-22 05:09:50.205472	\N	\N
27	\N	2014-01-22 13:54:04.870527	2014-01-22 13:54:04.870527	\N	\N
51	Jenny.JPG	2014-01-22 22:39:49.191662	2014-01-22 22:39:49.191662	\N	\N
52	meetup.JPG	2014-01-22 22:43:58.41089	2014-01-22 22:43:58.41089	\N	\N
53	image.jpg	2014-01-22 22:46:01.934216	2014-01-22 22:46:01.934216	\N	\N
54	image.jpg	2014-01-22 22:49:38.770589	2014-01-22 22:49:38.770589	\N	\N
55	\N	2014-01-22 22:56:12.773277	2014-01-22 22:56:12.773277	\N	\N
56	image.jpg	2014-01-22 22:56:38.965581	2014-01-22 22:56:38.965581	\N	\N
57	image.jpg	2014-01-22 22:57:59.756819	2014-01-22 22:57:59.756819	\N	\N
58	image.jpg	2014-01-22 23:12:54.888363	2014-01-22 23:12:54.888363	\N	\N
59	image.jpg	2014-01-22 23:21:07.105772	2014-01-22 23:21:07.105772	\N	\N
60	image.jpg	2014-01-22 23:22:54.222262	2014-01-22 23:22:54.222262	\N	\N
61	image.jpg	2014-01-22 23:23:28.144087	2014-01-22 23:23:28.144087	\N	\N
62	image.jpg	2014-01-22 23:29:28.631428	2014-01-22 23:29:28.631428	\N	\N
63	image.jpg	2014-01-22 23:52:40.737047	2014-01-22 23:52:40.737047	\N	\N
64	image.jpg	2014-01-23 00:18:06.370192	2014-01-23 00:18:06.370192	\N	\N
65	image.jpg	2014-01-23 01:00:30.984418	2014-01-23 01:00:30.984418	\N	\N
66	image.jpg	2014-01-23 04:46:02.076826	2014-01-23 04:46:02.076826	\N	\N
67	PaperCamera2012-12-15-10-27-41.jpg	2014-01-23 15:10:21.540407	2014-01-23 15:10:21.540407	\N	\N
68	image.jpg	2014-01-23 15:30:11.46619	2014-01-23 15:30:11.46619	\N	\N
69	image.jpg	2014-01-23 15:57:11.368789	2014-01-23 15:57:11.368789	\N	\N
70	booya.jpeg	2014-01-23 17:31:15.138529	2014-01-23 17:31:15.138529	\N	\N
71	Blinds.jpg	2014-01-23 19:25:50.355577	2014-01-23 19:25:50.355577	\N	\N
72	image.jpg	2014-01-24 00:24:28.752016	2014-01-24 00:24:28.752016	\N	\N
73	image.jpg	2014-01-24 02:48:16.713291	2014-01-24 02:48:16.713291	\N	\N
74	image.jpg	2014-01-24 12:47:17.001177	2014-01-24 12:47:17.001177	\N	\N
\.


--
-- Name: images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('images_id_seq', 74, true);


--
-- Data for Name: polls; Type: TABLE DATA; Schema: public; Owner: -
--

COPY polls (id, question, button1, button2, origin_poll, address, response1, response2, created_at, updated_at, status, image_id, user_id, identifier) FROM stdin;
15	U cool	Yes	No	\N		Yeso	Noo	2014-01-16 20:41:22.50251	2014-01-16 20:41:22.50251	\N	8	\N	\N
17	Question	Yes	No	\N	grcote@gmail.com	Y1	N1	2014-01-16 21:37:00.749024	2014-01-16 21:37:00.749024	\N	10	\N	\N
16	Do I rip more than just farts?	Yes	No	\N		Yeah I know I'm a badass	Whatever sucka	2014-01-16 21:35:43.662583	2014-01-16 21:42:40.354074	sent	9	\N	\N
18	Do I rip more than just farts?	Yes	No	\N		Yeah I know I'm a badass	Whatever sucka	2014-01-16 21:43:01.118733	2014-01-16 21:43:01.118733	\N	9	\N	\N
1	Am I a douchebag?	Yes	No	\N		You are correct	Clearly you don't know what a douchebag is.	2014-01-10 19:01:50.468238	2014-01-10 20:36:25.152599	sent	\N	\N	\N
19	Q	B	B	\N		R	T	2014-01-16 21:46:13.892157	2014-01-16 21:46:13.892157	\N	11	\N	\N
20	Do I rip more than just farts?	Yes	No	\N		Yeah I know I'm a badass	Whatever sucka	2014-01-16 21:48:04.267471	2014-01-16 21:48:04.267471	\N	9	\N	\N
2	Do you wish to support Afri-pads?	Of Course	Gross	\N		Thank you for drying my "week of shame"	Now I have to use dirt, sticks and leaves	2014-01-10 20:41:49.336876	2014-01-10 20:44:18.517954	sent	\N	\N	\N
3	Do I look fat in this?	Yes, you do. 	No, you look beautiful!	\N		You're an asshole! 	You're a liar and and Asshole!	2014-01-10 21:01:34.271194	2014-01-10 21:01:53.992385	sent	\N	\N	\N
22	dsaf	dsf	sdfa	\N		dsf	sdaf	2014-01-16 23:01:04.527911	2014-01-16 23:01:09.808513	sent	13	\N	\N
23	dsaf	dsf	sdfa	\N		dsf	sdaf	2014-01-16 23:01:19.171548	2014-01-16 23:01:19.171548	\N	13	\N	\N
4	Does it look like I have a huge dong?	Yes	No	\N		Figured you'd notice you perv!	Look a bit closer.	2014-01-10 21:40:11.491272	2014-01-10 21:45:53.022253	sent	\N	\N	\N
36	Am I cooler than Seth?	Yes	No	\N	\N	You are wrong!	You are correct!	2014-01-17 21:52:56.920208	2014-01-17 21:53:00.907231	sent	19	\N	\N
21	Am I cute, even after a nap?	R	R	\N		G	R	2014-01-16 21:55:28.399024	2014-01-17 00:35:26.924286	sent	12	\N	\N
5	Does this mustache make me look handsome?	Yes	No	\N		I offer free mustache ride... To the Ladies only.	Jealous much?... You know it's totally bad ass!	2014-01-10 21:54:05.198132	2014-01-11 02:19:35.265554	sent	\N	\N	\N
6	swingin			\N				2014-01-11 07:34:53.571865	2014-01-11 07:34:53.571865	\N	\N	\N	\N
7	swingin	ff	 kg	\N		ff	 sh	2014-01-11 07:35:30.327788	2014-01-11 07:35:30.327788	\N	\N	\N	\N
24	Am I cute, even after a nap?	Yes	No	\N	\N	I knew you were smarter than you look.	Whatever... Don't know why I'm even asking you.	2014-01-17 00:38:02.004477	2014-01-17 00:41:32.269829	sent	14	\N	\N
8	On a scale of 1 to 10, how cute am I?	A perfect 10	A zero	\N		Good for you... For a guy that's known for being into ugly fat chicks, you have pretty good taste.	Go fuck yourself!.... I've seen your kids.  They're homely.	2014-01-11 17:07:34.403941	2014-01-11 17:13:05.292884	sent	\N	\N	\N
25	Am I cute, even after a nap?	Yes	No	\N	\N	I knew you were smarter than you look.	Whatever... Don't know why I'm even asking you.	2014-01-17 01:07:11.356382	2014-01-17 01:07:11.356382	\N	14	\N	\N
9	Am I awesome or what?	Yes	No	\N		You better believe it.	Whatever nerd!	2014-01-12 01:18:37.653543	2014-01-12 01:20:09.141946	sent	\N	\N	\N
10	Did u drink this?	Yes	No	\N	G@	12 Step?	Admitting is first step	2014-01-13 01:33:07.027774	2014-01-13 01:33:31.64503	sent	\N	\N	\N
11	Yes	No	No	\N		Yes	Yes	2014-01-15 23:03:26.193461	2014-01-15 23:03:26.193461	\N	3	\N	\N
12	Am I Cooler Than Gerard?	Yes	No	\N		Yo Mama	Yes, my young Paduwan	2014-01-15 23:30:11.213549	2014-01-15 23:30:14.291915	sent	4	\N	\N
13	Does my daddy rule?			\N				2014-01-15 23:30:24.178743	2014-01-15 23:30:24.178743	\N	5	\N	\N
14				\N				2014-01-16 18:16:13.79724	2014-01-16 18:16:13.79724	\N	7	\N	\N
26	tgf	yes	no	\N	\N			2014-01-17 05:41:08.724917	2014-01-17 05:41:08.724917	\N	15	\N	\N
27	Am I cooler than Seth?	Yes	No	\N	\N	You are wrong!	You are correct!	2014-01-17 19:25:11.922806	2014-01-17 19:25:28.177396	sent	16	\N	\N
28	Am I cooler than Seth?	Yes	No	\N	\N	You are high!	You are correct!	2014-01-17 19:28:15.949281	2014-01-17 19:29:09.409403	sent	16	\N	\N
29	Am I cooler than Seth?	Yes	No	\N	\N	You are high!bb	You are correct!	2014-01-17 19:30:58.396745	2014-01-17 19:31:01.47046	sent	16	\N	\N
30	Am I cooler than Seth?	Yes	No	\N	\N	You are wrong!	You are correct!	2014-01-17 19:34:39.173113	2014-01-17 19:34:41.66084	sent	16	\N	\N
31	Am I cooler than Seth?	Yes	No	\N	\N	You are wrong!	You are correct!	2014-01-17 20:33:52.341447	2014-01-17 20:34:19.444439	sent	17	\N	\N
32	Is Matt cooler than Seth?	Yes	No	\N	\N	Bitch please!!!... you gotta ways to go.	Hmm... clearly you are smarter than you are cool!	2014-01-17 20:51:31.08364	2014-01-17 20:51:38.265112	sent	18	\N	\N
33	Is Matt cooler than Seth?	Yes	No	\N	\N	Bitch please!!!... you gotta ways to go.	Hmm... clearly you are smarter than you are cool!	2014-01-17 20:59:16.076628	2014-01-17 20:59:29.982769	sent	18	\N	\N
34	Am I cooler than Seth?	Yes	No	\N	\N	You are wrong!	You are correct!	2014-01-17 21:41:53.31655	2014-01-17 21:41:55.128282	sent	19	\N	\N
35	Am I cooler than Seth?	Yes	No	\N	\N	You are wrong!	You are correct!	2014-01-17 21:42:35.74946	2014-01-17 21:42:39.169619	sent	19	\N	\N
43	Chang	Yes	No	\N	\N	Fight	Bfgjg	2014-01-17 22:45:35.997774	2014-01-17 22:46:01.160345	sent	21	\N	\N
37	Am I cooler than Seth's forehead?	Yes	No	\N	\N	Right, he's a sweaty pig.	Hard to beat a good shine!	2014-01-17 22:15:57.124027	2014-01-17 22:17:38.240832	sent	19	\N	\N
38	Am I cooler than Seth's forehead?	Yes	No	\N	\N	Right, he's a sweaty pig.	Hard to beat a good shine!	2014-01-17 22:19:40.734032	2014-01-17 22:19:44.841859	sent	19	\N	\N
39	Am I cooler than Seth's forehead?	Yes	No	\N	\N	Right, he's a sweaty pig.	Hard to beat a good shine!	2014-01-17 22:26:37.960524	2014-01-17 22:26:43.731494	sent	19	\N	\N
40	Am I cooler than Seth's forehead?	Yes	No	\N	\N	Right, he's a sweaty pig.	Hard to beat a good shine!	2014-01-17 22:31:36.566258	2014-01-17 22:31:41.020984	sent	19	\N	\N
41	Fagggggg	Yes	No	\N	\N	Noggfvv	Ghhff	2014-01-17 22:33:46.596746	2014-01-17 22:33:54.31668	sent	20	\N	\N
42	Fagggggg	Yes	No	\N	\N	Noggfvv	Ghhff	2014-01-17 22:43:06.920979	2014-01-17 22:43:06.920979	\N	20	\N	\N
44	Chang	Yes	No	\N	\N	Fight	Bfgjg	2014-01-17 22:47:55.535031	2014-01-17 22:48:00.517957	sent	21	\N	\N
45	Am I Cooler Than Seth?	Yes	No	\N	\N			2014-01-17 22:51:32.858218	2014-01-17 22:51:41.640605	sent	22	\N	\N
46		Yes	No	\N	\N			2014-01-22 03:25:40.846987	2014-01-22 03:25:40.846987	\N	24	1	c8bd1f65
47	loblaw	Yes	No	\N	\N	Sorry...wrong	Correct	2014-01-22 04:47:54.564749	2014-01-22 04:49:18.364351	\N	25	1	fea23730
48	Why am I so awesome?	Good looks.	Brains	\N	\N	Good for you... You're smarter than you look.	Thanks for noticing.	2014-01-22 05:12:48.058782	2014-01-22 05:16:31.059555	sent	26	1	810dbfeb
49	Do you prefer it in the can?	Yes	No	\N	\N	Figured you would.... Gay boy!	Don't lie.... Gay boy!	2014-01-22 16:02:43.742108	2014-01-22 16:03:13.111395	sent	27	1	7c694f07
50	Do I rip?	Yes	No	\N	\N	Dish	Sjshs	2014-01-22 22:47:02.019865	2014-01-22 22:47:40.591434	sent	53	1	68983b38
51	Am I Allergic to Shellfish?	Yes	No	\N	\N	Bingo	That is not a bong.	2014-01-22 22:50:32.599392	2014-01-22 22:50:36.543859	sent	54	2	fd678527
52	Do I take it in the 5 hole?	Yes	No	\N	\N	Yep you do	Dssd	2014-01-22 22:59:03.252144	2014-01-22 22:59:11.863635	sent	57	1	da089d82
53	Want some candy little girl?	Yes	No	\N	\N	Hop in my van... Candy tastes sweeter in the car.	Fdd	2014-01-22 23:14:02.482897	2014-01-22 23:14:10.29113	sent	58	1	4b0c46ba
54	Ghhfgjfgn	Yes	No	\N	\N			2014-01-22 23:21:21.377241	2014-01-22 23:21:29.633119	sent	59	1	197bd94f
55	Hgdgh	Yes	No	\N	\N			2014-01-22 23:23:10.196509	2014-01-22 23:23:17.761579	sent	60	1	2fb2513f
56	Hungry?	Yes	No	\N	\N	Sorry, but you probably will remain so 	You're lucky	2014-01-22 23:24:35.519284	2014-01-22 23:24:39.988305	sent	61	2	7186da2d
57	Am I as badass as Uncle Seth?	Yes	Nope	\N	\N	Wrong... Check back in a few days once you've gotten a bit more badass.	Correct... You're smarter than you look.	2014-01-22 23:54:58.829254	2014-01-22 23:55:35.446856	sent	63	1	a587603e
58	Is this a urinal filled with ice?	Yes	No	57	\N	Only a homo would know that 	Yes it is idiot 	2014-01-23 00:19:23.471817	2014-01-23 00:19:29.050637	sent	64	3	f64f0a46
59	What's on my right knee?	A long penis	A Shadow	\N	\N	Whatever you perv!... Get your mind out of the gutter!	Yeah... Right... It's a big 12 inch shadow.	2014-01-23 01:06:06.461057	2014-01-23 01:06:39.972272	sent	65	1	375717f3
60	What's on my right knee?	A long penis	A Shadow	59	\N	Whatever you perv!... Get your mind out of the gutter!	Yeah... Right... It's a big 12 inch shadow.	2014-01-23 04:28:22.221273	2014-01-23 04:28:22.221273	\N	65	1	6c4e6127
61	What's on my right knee?	A long penis	A Shadow	59	\N	Whatever you perv!... Get your mind out of the gutter!	Yeah... Right... It's a big 12 inch shadow.	2014-01-23 04:28:44.204873	2014-01-23 04:28:52.85328	sent	65	1	b3b78a51
62	I owe you one punch 	You are correct and the best 	I don't play that game 	59	\N	Don't be a wuss 	Pussy 	2014-01-23 04:47:07.618893	2014-01-23 04:47:07.618893	\N	66	3	a57e8798
63	I owe you one punch 	You are correct and the best 	I don't play that game 	59	\N	Don't be a wuss 	Pussy 	2014-01-23 04:47:30.844064	2014-01-23 04:47:30.844064	\N	66	3	2cc8161c
64	I owe you one punch 	You are correct and the best 	I don't play that game 	59	\N	Don't be a wuss 	Pussy 	2014-01-23 04:47:44.1676	2014-01-23 04:47:48.958516	sent	66	3	f4388b22
65	Fuji	Yes	No	\N	\N	Hfgjjbb	Hfgjjjgg	2014-01-23 15:30:31.179036	2014-01-23 15:33:09.413879	\N	68	1	dc5c9e23
66	Can I interest you in a free mustache ride?	You're so cute and clever!	Piss off dirtbag!	\N	\N	Hop on baby and grab a hold of my handlebars!	C'mon sweetie... you know you want........ whatever....... bitch!	2014-01-23 17:34:59.146969	2014-01-23 17:37:54.404867	sent	70	1	ae6ddd97
67		Yes	No	\N	\N			2014-01-23 19:26:00.207623	2014-01-23 19:26:00.207623	\N	71	1	f8650cf9
68	What's on my right knee?	A long penis	A Shadow	61	\N	Whatever you perv!... Get your mind out of the gutter!	Yeah... Right... It's a big 12 inch shadow.	2014-01-23 20:48:30.139526	2014-01-23 20:49:12.745129	sent	65	1	8c3c1809
69	Zoe	Yes	No	69	\N			2014-01-24 02:48:28.631594	2014-01-24 02:48:37.040459	sent	73	1	7604094c
70	Zoe	Yes	No	69	\N			2014-01-24 03:01:27.734123	2014-01-24 03:01:33.62282	sent	73	1	4d874080
71	Zoe3	Yes	No	69	\N			2014-01-24 03:12:50.119238	2014-01-24 03:12:59.402006	sent	73	1	8096ceee
72	Zoe	Yes	No	69	\N			2014-01-24 12:28:26.088321	2014-01-24 12:28:58.652552	sent	73	1	9d4b9fe6
73		Yes	No	73	\N			2014-01-24 12:47:30.268674	2014-01-24 12:47:30.2825	\N	74	1	e230946e
74	Am I Allergic to Shellfish?	Yes	No	74	\N	Bingo	That is not a bong.	2014-01-24 15:31:56.299997	2014-01-24 15:32:02.132546	sent	54	2	fe344aae
75	Am I Allergic to Shellfish?	Yes	No	74	\N	Bingo	That is not a bong.	2014-01-24 15:32:45.502935	2014-01-24 15:32:49.721904	sent	54	2	07f30653
\.


--
-- Name: polls_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('polls_id_seq', 75, true);


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY schema_migrations (version) FROM stdin;
20140109181703
20140109193747
20140110024557
20140113174535
20140113174647
20140114170141
20140114214323
20140114222931
20140115233558
20140121180641
20140121181245
20140121211320
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY users (id, email, encrypted_password, reset_password_token, reset_password_sent_at, remember_created_at, sign_in_count, current_sign_in_at, last_sign_in_at, current_sign_in_ip, last_sign_in_ip, created_at, updated_at) FROM stdin;
2	grcote@gmail.com	$2a$10$BrlJZ15N57y8YWGI0dH8/.3LU8wiLyAkt5XDPDuIAUijuyzRhcCRW	\N	\N	\N	9	2014-01-24 15:31:25.335733	2014-01-24 00:24:38.036687	174.232.199.70	71.229.168.92	2014-01-22 20:02:21.508326	2014-01-24 15:33:24.743621
4	jennygeyer09@gmail.con	$2a$10$7tCWhblyUf9Yuud/WDfRUebs.hu6xSw2eVMSVSpPO.DH0Yh6UTHT6	\N	\N	\N	1	2014-01-23 00:17:24.008035	2014-01-23 00:17:24.008035	71.229.168.92	71.229.168.92	2014-01-23 00:17:24.001701	2014-01-23 00:17:24.009494
3	bthemmert@yahoo.com	$2a$10$L.YR18NFcsUIQ64XefWNqOggmwCcdFeCGoR1vnVBf3NdCyum1C3Iu	\N	\N	2014-01-23 04:45:13.14337	4	2014-01-24 01:14:36.064268	2014-01-23 04:45:37.971747	71.218.189.244	174.232.129.204	2014-01-23 00:17:11.138621	2014-01-24 01:14:36.067148
1	sethgeyer@yahoo.com	$2a$10$/OSsf17TuwB3Q4UK01OsA.gXu/c2QqAE1i7JszW1uTjp.SefuKtOK	\N	\N	\N	17	2014-01-24 12:26:01.881445	2014-01-23 21:19:45.640099	71.229.168.92	166.147.88.15	2014-01-22 03:25:30.898822	2014-01-24 12:26:01.884758
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('users_id_seq', 4, true);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: polls_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY polls
    ADD CONSTRAINT polls_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

