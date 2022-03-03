import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  // Uses an environment variable for port number or defaults to 3000
  
  const port = process.env.PORT || 3000;
  await app.listen(port);
}
bootstrap();
