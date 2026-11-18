import '../utils/nutrition_calc.dart' show BmiCategory;

/// Manual i18n tables (ES default, EN). Keeps Fase 0 free of codegen;
/// migrate to slang/gen-l10n later without touching widgets
/// (widgets only read [AppStrings] via provider).
abstract class AppStrings {
  const AppStrings();
  String get appName;
  String get onboardingTitle;
  String get onboardingSubtitle;
  String get startPlan;
  String get alreadyHaveAccount;
  String get home;
  String get recipes;
  String get progress;
  String get profile;
  String get login;
  String get retry;
  String get loading;
  String get supabaseNotConfigured;
  String get placeholderBody;

  // Fase 1 — auth
  String get email;
  String get password;
  String get displayName;
  String get signIn;
  String get register;
  String get signOut;
  String get needAccount;
  String get haveAccount;
  String get authError;
  String get profileTitle;
  String get goalSettings;

  // Fase 1 — goals
  String get mainGoal;
  String get activityLevel;
  String get calorieTarget;
  String get goalLose;
  String get goalMaintain;
  String get goalGain;
  String get actSedentary;
  String get actLight;
  String get actModerate;
  String get actActive;
  String get saved;

  // Fase 1 — diary
  String get remaining;
  String get target;
  String get foods;
  String get exercise;
  String get macroDistribution;
  String get proteins;
  String get carbs;
  String get fats;
  String get mealLog;
  String get breakfast;
  String get lunch;
  String get dinner;
  String get snack;
  String get notLoggedYet;
  String get addToMeal;
  String get recents;
  String get frequentInMeal;
  String get foodName;
  String get grams;
  String get save;
  String get cancel;
  String get delete;
  String get manualEntry;
  String get tipScale;
  String get emptyDay;

  // Fase 2 — food scan
  String get scanTitle;
  String get scanFood;
  String get scanHint;
  String get takePhoto;
  String get pickFromGallery;
  String get retakePhoto;
  String get analyze;
  String get analyzing;
  String get scanError;
  String get addManually;
  String get confirmScan;
  String get selectMeal;
  String get saveToDiary;
  String get saveError;
  String get missingAiKey;
  String get detectedFoods;
  String get addToDiary;
  String get emptyScan;
  String get noFoodDetected;

  // Fase 2 — auth validation
  String get confirmPassword;
  String get togglePasswordVisibility;
  String get passwordsDoNotMatch;
  String get passwordTooShort;
  String get invalidEmail;

  // Fase 3 — body data, progress, recipes
  String get bodyData;
  String get yourData;
  String get yourGoal;
  String get weight;
  String get height;
  String get goalWeight;
  String get bmi;
  String get bmiUnderweight;
  String get bmiNormal;
  String get bmiOverweight;
  String get bmiObese;
  String get bmiAdultNote;
  String get invalidWeight;
  String get invalidHeight;
  String get invalidGoalWeight;
  String get goalMustBeLower;
  String get goalMustBeHigher;
  String get notSet;
  String get settingsSaveError;
  String get currentWeight;
  String get startWeight;
  String get logWeight;
  String get date;
  String get weightSaved;
  String get weightSaveError;
  String get weightHistory;
  String get noWeightYet;
  String get chartNeedsTwo;
  String get goalProgress;
  String get goalReached;
  String get goalLine;
  String get setGoalWeightHint;
  String get addHeightHint;
  String get bmiNeedsWeight;
  String get goToProfile;
  String get confirmDeleteWeight;
  String get healthyRecipes;
  String get recipesSubtitle;
  String get recommendedForYou;
  String get filterAll;
  String get ingredients;
  String get preparation;
  String get perServing;
  String get recipeNotFound;
  String get noRecipes;
  String bmiValue(String value);
  String kgValue(double value);
  String weightChange7d(String signedKg);
  String goalWeightValue(String kg);
  String remainingToGoal(String kg);
  String minutesValue(int value);

  /// Localized label of a BMI category.
  String bmiCategoryLabel(BmiCategory category) => switch (category) {
    BmiCategory.underweight => bmiUnderweight,
    BmiCategory.normal => bmiNormal,
    BmiCategory.overweight => bmiOverweight,
    BmiCategory.obese => bmiObese,
  };

  String greeting(String name);
  String kcalValue(int value);

  static AppStrings ofCode(String code) =>
      code.startsWith('en') ? const EnStrings() : const EsStrings();
}

class EsStrings extends AppStrings {
  const EsStrings();
  @override String get appName => 'NutriFit';
  @override String get onboardingTitle => 'Tu plan de nutrición inteligente';
  @override String get onboardingSubtitle =>
      'Alcanza tus objetivos de salud con recetas personalizadas, racha de hábitos y un contador preciso de macros.';
  @override String get startPlan => 'Comienza tu plan';
  @override String get alreadyHaveAccount => 'Ya tengo una cuenta';
  @override String get home => 'Inicio';
  @override String get recipes => 'Recetas';
  @override String get progress => 'Progreso';
  @override String get profile => 'Perfil';
  @override String get login => 'Iniciar sesión';
  @override String get retry => 'Reintentar';
  @override String get loading => 'Cargando…';
  @override String get supabaseNotConfigured =>
      'Supabase no configurado. Ejecuta con --dart-define SUPABASE_URL/ANON_KEY.';
  @override String get placeholderBody =>
      'Pantalla base de Fase 0. La funcionalidad llega en Fase 1+.';

  @override String get email => 'Correo electrónico';
  @override String get password => 'Contraseña';
  @override String get displayName => 'Nombre';
  @override String get signIn => 'Entrar';
  @override String get register => 'Crear cuenta';
  @override String get signOut => 'Cerrar sesión';
  @override String get needAccount => '¿No tienes cuenta? Regístrate';
  @override String get haveAccount => '¿Ya tienes cuenta? Entra';
  @override String get authError => 'No se pudo autenticar. Revisa tus datos.';
  @override String get profileTitle => 'Perfil';
  @override String get goalSettings => 'Configuración de Objetivos';
  @override String get mainGoal => 'Meta principal';
  @override String get activityLevel => 'Nivel de actividad';
  @override String get calorieTarget => 'Meta de calorías';
  @override String get goalLose => 'Perder grasa corporal';
  @override String get goalMaintain => 'Mantener peso';
  @override String get goalGain => 'Ganar masa muscular';
  @override String get actSedentary => 'Sedentario';
  @override String get actLight => 'Ligero';
  @override String get actModerate => 'Moderadamente activo';
  @override String get actActive => 'Muy activo';
  @override String get saved => 'Guardado';
  @override String get remaining => 'Restantes';
  @override String get target => 'Objetivo';
  @override String get foods => 'Alimentos';
  @override String get exercise => 'Ejercicio';
  @override String get macroDistribution => 'Distribución de Macronutrientes';
  @override String get proteins => 'Proteínas';
  @override String get carbs => 'Carbohidratos';
  @override String get fats => 'Grasas';
  @override String get mealLog => 'Registro de Comidas';
  @override String get breakfast => 'Desayuno';
  @override String get lunch => 'Almuerzo';
  @override String get dinner => 'Cena';
  @override String get snack => 'Snacks';
  @override String get notLoggedYet => 'Aún no registrado';
  @override String get addToMeal => 'Agregar';
  @override String get recents => 'Recientes';
  @override String get frequentInMeal => 'Frecuentes';
  @override String get foodName => 'Alimento';
  @override String get grams => 'Gramos';
  @override String get save => 'Guardar';
  @override String get cancel => 'Cancelar';
  @override String get delete => 'Eliminar';
  @override String get manualEntry => 'Registro manual';
  @override String get tipScale =>
      'Tip: Pesando tus alimentos con balanza digital puedes mejorar la precisión del seguimiento de calorías hasta en un 30%.';
  @override String get emptyDay => 'Sin registros hoy. Agrega tu primera comida.';

  @override String get scanTitle => 'Escanear comida';
  @override String get scanFood => 'Escanear';
  @override String get scanHint =>
      'Toma una foto o elige una imagen de tu galería para estimar las calorías y macros automáticamente.';
  @override String get takePhoto => 'Tomar foto';
  @override String get pickFromGallery => 'Elegir de la galería';
  @override String get retakePhoto => 'Cambiar foto';
  @override String get analyze => 'Analizar';
  @override String get analyzing => 'Analizando tu foto…';
  @override String get scanError =>
      'No se pudo analizar la foto. Revisa tu conexión o la clave de la IA e inténtalo de nuevo.';
  @override String get addManually => 'Agregar manualmente';
  @override String get confirmScan => 'Confirmar estimación';
  @override String get selectMeal => '¿A qué comida pertenece?';
  @override String get saveToDiary => 'Guardar en el diario';
  @override String get saveError => 'No se pudo guardar en el diario.';
  @override String get missingAiKey =>
      'Falta la clave de la IA. Ejecuta con --dart-define GEMINI_API_KEY=...';
  @override String get detectedFoods => 'Alimentos detectados';
  @override String get addToDiary => 'Agregar al diario';
  @override String get emptyScan => 'No hay resultados de escaneo para confirmar.';
  @override String get noFoodDetected =>
      'No se detectó comida en la foto. Usa una imagen más clara o agrega el alimento manualmente.';

  @override String get confirmPassword => 'Confirmar contraseña';
  @override String get togglePasswordVisibility => 'Mostrar contraseña';
  @override String get passwordsDoNotMatch => 'Las contraseñas no coinciden';
  @override String get passwordTooShort => 'Mínimo 6 caracteres';
  @override String get invalidEmail => 'Correo inválido';
  @override String get bodyData =>
      'Datos corporales';
  @override String get yourData =>
      'Tus datos';
  @override String get yourGoal =>
      'Tu objetivo';
  @override String get weight =>
      'Peso (kg)';
  @override String get height =>
      'Estatura (cm)';
  @override String get goalWeight =>
      'Peso objetivo (kg)';
  @override String get bmi =>
      'IMC';
  @override String get bmiUnderweight =>
      'Bajo peso';
  @override String get bmiNormal =>
      'Peso normal';
  @override String get bmiOverweight =>
      'Sobrepeso';
  @override String get bmiObese =>
      'Obesidad';
  @override String get bmiAdultNote =>
      'El IMC es una referencia general para adultos.';
  @override String get invalidWeight =>
      'Ingresa un peso válido (20–500 kg)';
  @override String get invalidHeight =>
      'Ingresa una estatura válida (50–260 cm)';
  @override String get invalidGoalWeight =>
      'Ingresa un peso objetivo válido (20–500 kg)';
  @override String get goalMustBeLower =>
      'Para perder peso, tu objetivo debe ser menor a tu peso actual';
  @override String get goalMustBeHigher =>
      'Para ganar peso, tu objetivo debe ser mayor a tu peso actual';
  @override String get notSet =>
      'Sin definir';
  @override String get settingsSaveError =>
      'No se pudo guardar. Inténtalo de nuevo.';
  @override String get currentWeight =>
      'Peso actual';
  @override String get startWeight =>
      'Peso inicial';
  @override String get logWeight =>
      'Registrar peso';
  @override String get date =>
      'Fecha';
  @override String get weightSaved =>
      'Peso registrado';
  @override String get weightSaveError =>
      'No se pudo guardar el peso.';
  @override String get weightHistory =>
      'Historial de peso';
  @override String get noWeightYet =>
      'Aún no tienes registros de peso. Agrega el primero para ver tu progreso.';
  @override String get chartNeedsTwo =>
      'Registra otro peso para ver cómo evoluciona tu gráfica.';
  @override String get goalProgress =>
      'Progreso hacia tu meta';
  @override String get goalReached =>
      '¡Meta alcanzada!';
  @override String get goalLine =>
      'Meta';
  @override String get setGoalWeightHint =>
      'Define tu peso objetivo en el perfil para seguir tu avance.';
  @override String get addHeightHint =>
      'Agrega tu estatura en el perfil para calcular tu IMC.';
  @override String get bmiNeedsWeight =>
      'Registra tu peso para calcular tu IMC.';
  @override String get goToProfile =>
      'Ir al perfil';
  @override String get confirmDeleteWeight =>
      '¿Eliminar este registro de peso?';
  @override String get healthyRecipes =>
      'Recetas Saludables';
  @override String get recipesSubtitle =>
      'Inspiración para comer delicioso hoy';
  @override String get recommendedForYou =>
      'Recomendadas para ti';
  @override String get filterAll =>
      'Todas';
  @override String get ingredients =>
      'Ingredientes';
  @override String get preparation =>
      'Preparación';
  @override String get perServing =>
      'Valores aproximados por porción';
  @override String get recipeNotFound =>
      'No encontramos esta receta.';
  @override String get noRecipes =>
      'No hay recetas en esta categoría.';
  @override String bmiValue(String value) => 'Tu IMC: $value';
  @override String kgValue(double value) => '${value.toStringAsFixed(1)} kg';
  @override String weightChange7d(String signedKg) => '$signedKg kg en 7 días';
  @override String goalWeightValue(String kg) => 'Meta: $kg';
  @override String remainingToGoal(String kg) => 'Te faltan $kg';
  @override String minutesValue(int value) => '$value min';
  @override String greeting(String name) => 'Hola, $name';
  @override String kcalValue(int value) => '$value kcal';
}

class EnStrings extends AppStrings {
  const EnStrings();
  @override String get appName => 'NutriFit';
  @override String get onboardingTitle => 'Your smart nutrition plan';
  @override String get onboardingSubtitle =>
      'Reach your health goals with personalized recipes, habit streaks and an accurate macro tracker.';
  @override String get startPlan => 'Start your plan';
  @override String get alreadyHaveAccount => 'I already have an account';
  @override String get home => 'Home';
  @override String get recipes => 'Recipes';
  @override String get progress => 'Progress';
  @override String get profile => 'Profile';
  @override String get login => 'Log in';
  @override String get retry => 'Retry';
  @override String get loading => 'Loading…';
  @override String get supabaseNotConfigured =>
      'Supabase not configured. Run with --dart-define SUPABASE_URL/ANON_KEY.';
  @override String get placeholderBody =>
      'Phase 0 placeholder screen. Functionality lands in Phase 1+.';

  @override String get email => 'Email';
  @override String get password => 'Password';
  @override String get displayName => 'Name';
  @override String get signIn => 'Sign in';
  @override String get register => 'Sign up';
  @override String get signOut => 'Sign out';
  @override String get needAccount => "Don't have an account? Sign up";
  @override String get haveAccount => 'Already have an account? Sign in';
  @override String get authError => 'Authentication failed. Check your data.';
  @override String get profileTitle => 'Profile';
  @override String get goalSettings => 'Goal Settings';
  @override String get mainGoal => 'Main goal';
  @override String get activityLevel => 'Activity level';
  @override String get calorieTarget => 'Calorie target';
  @override String get goalLose => 'Lose body fat';
  @override String get goalMaintain => 'Maintain weight';
  @override String get goalGain => 'Gain muscle';
  @override String get actSedentary => 'Sedentary';
  @override String get actLight => 'Light';
  @override String get actModerate => 'Moderately active';
  @override String get actActive => 'Very active';
  @override String get saved => 'Saved';
  @override String get remaining => 'Remaining';
  @override String get target => 'Target';
  @override String get foods => 'Food';
  @override String get exercise => 'Exercise';
  @override String get macroDistribution => 'Macronutrient Breakdown';
  @override String get proteins => 'Protein';
  @override String get carbs => 'Carbs';
  @override String get fats => 'Fat';
  @override String get mealLog => 'Meal Log';
  @override String get breakfast => 'Breakfast';
  @override String get lunch => 'Lunch';
  @override String get dinner => 'Dinner';
  @override String get snack => 'Snacks';
  @override String get notLoggedYet => 'Not logged yet';
  @override String get addToMeal => 'Add';
  @override String get recents => 'Recent';
  @override String get frequentInMeal => 'Frequent';
  @override String get foodName => 'Food';
  @override String get grams => 'Grams';
  @override String get save => 'Save';
  @override String get cancel => 'Cancel';
  @override String get delete => 'Delete';
  @override String get manualEntry => 'Manual entry';
  @override String get tipScale =>
      'Tip: Weighing your food with a digital scale can improve calorie tracking accuracy by up to 30%.';
  @override String get emptyDay => 'No entries today. Add your first meal.';

  @override String get scanTitle => 'Scan food';
  @override String get scanFood => 'Scan';
  @override String get scanHint =>
      'Take a photo or pick an image from your gallery to estimate calories and macros automatically.';
  @override String get takePhoto => 'Take photo';
  @override String get pickFromGallery => 'Choose from gallery';
  @override String get retakePhoto => 'Change photo';
  @override String get analyze => 'Analyze';
  @override String get analyzing => 'Analyzing your photo…';
  @override String get scanError =>
      'Could not analyze the photo. Check your connection or the AI key and try again.';
  @override String get addManually => 'Add manually';
  @override String get confirmScan => 'Confirm estimate';
  @override String get selectMeal => 'Which meal does it belong to?';
  @override String get saveToDiary => 'Save to diary';
  @override String get saveError => 'Could not save to the diary.';
  @override String get missingAiKey =>
      'AI key missing. Run with --dart-define GEMINI_API_KEY=...';
  @override String get detectedFoods => 'Detected foods';
  @override String get addToDiary => 'Add to diary';
  @override String get emptyScan => 'There is no scan result to confirm.';
  @override String get noFoodDetected =>
      'No food was detected in the photo. Try a clearer image or add the food manually.';

  @override String get confirmPassword => 'Confirm password';
  @override String get togglePasswordVisibility => 'Show password';
  @override String get passwordsDoNotMatch => 'Passwords do not match';
  @override String get passwordTooShort => 'At least 6 characters';
  @override String get invalidEmail => 'Invalid email';
  @override String get bodyData =>
      'Body data';
  @override String get yourData =>
      'Your details';
  @override String get yourGoal =>
      'Your goal';
  @override String get weight =>
      'Weight (kg)';
  @override String get height =>
      'Height (cm)';
  @override String get goalWeight =>
      'Goal weight (kg)';
  @override String get bmi =>
      'BMI';
  @override String get bmiUnderweight =>
      'Underweight';
  @override String get bmiNormal =>
      'Normal weight';
  @override String get bmiOverweight =>
      'Overweight';
  @override String get bmiObese =>
      'Obesity';
  @override String get bmiAdultNote =>
      'BMI is a general reference for adults.';
  @override String get invalidWeight =>
      'Enter a valid weight (20–500 kg)';
  @override String get invalidHeight =>
      'Enter a valid height (50–260 cm)';
  @override String get invalidGoalWeight =>
      'Enter a valid goal weight (20–500 kg)';
  @override String get goalMustBeLower =>
      'To lose weight, your goal must be below your current weight';
  @override String get goalMustBeHigher =>
      'To gain weight, your goal must be above your current weight';
  @override String get notSet =>
      'Not set';
  @override String get settingsSaveError =>
      'Could not save. Please try again.';
  @override String get currentWeight =>
      'Current weight';
  @override String get startWeight =>
      'Starting weight';
  @override String get logWeight =>
      'Log weight';
  @override String get date =>
      'Date';
  @override String get weightSaved =>
      'Weight logged';
  @override String get weightSaveError =>
      'Could not save your weight.';
  @override String get weightHistory =>
      'Weight history';
  @override String get noWeightYet =>
      'No weight entries yet. Add your first one to see your progress.';
  @override String get chartNeedsTwo =>
      'Log another weight to see your chart evolve.';
  @override String get goalProgress =>
      'Progress toward your goal';
  @override String get goalReached =>
      'Goal reached!';
  @override String get goalLine =>
      'Goal';
  @override String get setGoalWeightHint =>
      'Set your goal weight in your profile to track your progress.';
  @override String get addHeightHint =>
      'Add your height in your profile to calculate your BMI.';
  @override String get bmiNeedsWeight =>
      'Log your weight to calculate your BMI.';
  @override String get goToProfile =>
      'Go to profile';
  @override String get confirmDeleteWeight =>
      'Delete this weight entry?';
  @override String get healthyRecipes =>
      'Healthy Recipes';
  @override String get recipesSubtitle =>
      'Inspiration to eat well today';
  @override String get recommendedForYou =>
      'Recommended for you';
  @override String get filterAll =>
      'All';
  @override String get ingredients =>
      'Ingredients';
  @override String get preparation =>
      'Preparation';
  @override String get perServing =>
      'Approximate values per serving';
  @override String get recipeNotFound =>
      'We could not find this recipe.';
  @override String get noRecipes =>
      'No recipes in this category.';
  @override String bmiValue(String value) => 'Your BMI: $value';
  @override String kgValue(double value) => '${value.toStringAsFixed(1)} kg';
  @override String weightChange7d(String signedKg) => '$signedKg kg in 7 days';
  @override String goalWeightValue(String kg) => 'Goal: $kg';
  @override String remainingToGoal(String kg) => '$kg to go';
  @override String minutesValue(int value) => '$value min';
  @override String greeting(String name) => 'Hi, $name';
  @override String kcalValue(int value) => '$value kcal';
}
