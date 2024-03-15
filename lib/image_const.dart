const splashIcon = 'assets/images/app_icon.svg';
const windIcon = 'assets/images/ic_wind.svg';
const humidityIcon = 'assets/images/ic_humidity.svg';
const tempIcon = 'assets/images/ic_temp.svg';
const cloudIcon = 'assets/images/ic_cloud.svg';
const cloudyIcon = 'assets/images/ic_cloudy.svg';
const nightIcon = 'assets/images/ic_night.svg';
const rainyIcon = 'assets/images/ic_rainy.svg';
const thunderstomIcon = 'assets/images/ic_thunderstom.svg';


String getIconUrl(String iconId) =>
    'https://raw.githubusercontent.com/1hanzla100/flutter-weather/07c38fc9fd21b2f380a6c56a30f0927183626a91/assets/svgs/${iconId}.svg';

String getSmallIconUrl(String iconId) =>
    'https://openweathermap.org/img/wn/${'04d'.substring(0, iconId.length - 1)}d@2x.png';