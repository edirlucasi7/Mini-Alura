CREATE TABLE category (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    code VARCHAR(20) NOT NULL,
    short_description VARCHAR(100),
    study_guide LONGTEXT,
    active BOOLEAN DEFAULT 0,
    order_in_category SMALLINT UNSIGNED,
    image_url VARCHAR(100),
    color_code VARCHAR(7)
);

CREATE TABLE subcategory (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    code VARCHAR(20) NOT NULL,
    short_description VARCHAR(100),
    study_guide LONGTEXT,
    active BOOLEAN DEFAULT 0,
    order_in_subcategory SMALLINT UNSIGNED,
    category_id BIGINT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(id)
);

CREATE TABLE instructor (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE course (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    code VARCHAR(20) NOT NULL,
    estimated_time_in_hours TINYINT UNSIGNED,
    visibility BOOLEAN,
    target_audience VARCHAR(50),
    resume VARCHAR(100),
    instructor_id BIGINT NOT NULL,
    subcategory_id BIGINT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES instructor(id),
    FOREIGN KEY (subcategory_id) REFERENCES subcategory(id)
);

CREATE TABLE section (
      id BIGINT AUTO_INCREMENT PRIMARY KEY,
      name VARCHAR(50) NOT NULL,
      code VARCHAR(20) NOT NULL,
      order_in_section TINYINT UNSIGNED,
      active BOOLEAN DEFAULT 0,
      test BOOLEAN DEFAULT 0,
      course_id BIGINT NOT NULL,
      FOREIGN KEY (course_id) REFERENCES course(id)
);

CREATE TABLE video (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    code VARCHAR(20) NOT NULL,
    url VARCHAR(100) NOT NULL,
    duration_in_minutes SMALLINT,
    transcription LONGTEXT,
    section_id BIGINT NOT NULL,
    FOREIGN KEY (section_id) REFERENCES section(id)
);

CREATE TABLE explanation (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    code VARCHAR(20) NOT NULL,
    text VARCHAR(100) NOT NULL,
    section_id BIGINT NOT NULL,
    FOREIGN KEY (section_id) REFERENCES section(id)
);

CREATE TABLE question (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    code VARCHAR(20) NOT NULL,
    enunciation VARCHAR(50) NOT NULL,
    type ENUM('SINGLE_ANSWER', 'MULTIPLE_ANSWERS', 'TRUE_OR_FALSE') DEFAULT 'SINGLE_ANSWER' NOT NULL,
    section_id BIGINT NOT NULL,
    FOREIGN KEY (section_id) REFERENCES section(id)
);

CREATE TABLE alternative (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    text VARCHAR(100) NOT NULL,
    order_in_alternative TINYINT UNSIGNED,
    is_correct BOOLEAN NOT NULL,
    justification VARCHAR(255),
    question_id BIGINT NOT NULL,
    FOREIGN KEY (question_id) REFERENCES question(id)
);