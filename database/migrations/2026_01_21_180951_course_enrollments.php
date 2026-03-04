<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // PERBAIKAN: Gunakan Schema::create karena tabelnya belum ada
        Schema::create('course_enrollments', function (Blueprint $table) {
            $table->id(); // Primary Key
            
            // Relasi ke User
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            
            // Relasi ke Course (Pastikan tabel courses sudah ada, atau hapus constrained jika belum)
            $table->foreignId('course_id'); 
            
            // Kolom Data Tambahan
            $table->integer('progress_percentage')->default(0);
            $table->enum('status', ['active', 'completed'])->default('active');
            
            // Kolom yang kamu mau tambahkan tadi
            $table->unsignedBigInteger('last_content_id')->nullable();

            // Opsional: Tambahkan Foreign Key ke module_contents jika tabelnya SUDAH ada.
            // Jika tabel 'module_contents' belum dibuat migrate-nya, baris di bawah ini akan error.
            // Saran: Jika ragu, komentar dulu baris $table->foreign ini.
             $table->foreign('last_content_id')
                   ->references('id')
                   ->on('module_contents')
                   ->onDelete('set null');

            $table->timestamps(); // created_at & updated_at
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Karena kita create, rollback-nya cukup dropIfExists
        Schema::dropIfExists('course_enrollments');
    }
};