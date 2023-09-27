void main() {
	char* video_memory = (char*) 0xb8000;

	*video_memory = 'H';
	*(video_memory + 2) = 'e';
	*(video_memory + 4) = 'l';
	*(video_memory + 6) = 'l';
	*(video_memory + 8) = 'o';
	*(video_memory + 10) = ',';
	*(video_memory + 12) = ' ';
	*(video_memory + 14) = 'W';
	*(video_memory + 16) = 'o';
	*(video_memory + 18) = 'r';
	*(video_memory + 20) = 'l';
	*(video_memory + 22) = 'd';
	*(video_memory + 24) = '!';
}