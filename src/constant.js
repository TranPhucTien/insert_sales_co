function randomDate(start, end) {
    let d = new Date(
        start.getTime() + Math.random() * (end.getTime() - start.getTime()),
    );
    d = `${d.getFullYear()}-${d.getMonth() + 1}-${d.getDate()}`;
    return d;
}

function randomFiveCharacter() {
    const s5 = (((1 + Math.random()) * 0x10000) | 0).toString(16);
    return s5;
}

export { randomDate, randomFiveCharacter };
