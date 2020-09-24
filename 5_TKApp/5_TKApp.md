# 5 - TKApp

## Description

Now you can play Flare-On on your watch! As long as you still have an arm left to put a watch on, or emulate the watch's operating system with sophisticated developer tools.

## Walkthrough


TKData
```
62 38 63 63 54 39 59 50 39

b8ccT9YP9
```

```
public static string Decode(byte[] e)
{
	string text = "";
	foreach (byte b in e)
	{
		text += Convert.ToChar((int)(b ^ 83)).ToString();
	}
	return text;
}
```

```
$ python3 Scripts/password_decode.py 

The decrypted password is: mullethat
```

MainPage

```
if (!string.IsNullOrEmpty(App.Password) && !string.IsNullOrEmpty(App.Note) && !string.IsNullOrEmpty(App.Step) && !string.IsNullOrEmpty(App.Desc))
```

TKData
```
public static void Init()
{
	double[] coordinates = TKData.GetCoordinates(Path.Combine(Application.Current.DirectoryInfo.Resource, "gallery", "04.jpg"));
	TKData.lat = coordinates[0];
	TKData.lon = coordinates[1];
}

public static double[] GetCoordinates(string imageFileName)
{
	double[] result;
	using (ExifReader exifReader = new ExifReader(imageFileName))
	{
		string text = "";
		string text2 = "";
		double[] array;
		double[] array2;
		if (exifReader.GetTagValue<double[]>(ExifTags.GPSLatitude, out array) && exifReader.GetTagValue<double[]>(ExifTags.GPSLongitude, out array2) && exifReader.GetTagValue<string>(ExifTags.GPSLatitudeRef, out text) && exifReader.GetTagValue<string>(ExifTags.GPSLongitudeRef, out text2))
		{
			double num = array2[0] + array2[1] / 60.0 + array2[2] / 3600.0;
			double num2 = array[0] + array[1] / 60.0 + array[2] / 3600.0;
			result = new double[]
			{
				(double)(text.StartsWith("N") ? 1 : -1) * num2,
				(double)(text2.StartsWith("E") ? 1 : -1) * num
			};
		}
		else
		{
			result = new double[2];
		}
	}
	return result;
}
```

The coordinates stored in the metadata of the image "04.jpg" are the following:

```
latitude = 34.6252
longitude = -97.2117
```

After that, it gets a list of next activities.

TodoPage

```
private void SetupList()
{
	List<TodoPage.Todo> list = new List<TodoPage.Todo>();
	if (!this.isHome)
	{
		list.Add(new TodoPage.Todo("go home", "and enable GPS", false));
	}
	else
	{
		TodoPage.Todo[] collection = new TodoPage.Todo[]
		{
			new TodoPage.Todo("hang out in tiger cage", "and survive", true),
			new TodoPage.Todo("unload Walmart truck", "keep steaks for dinner", false),
			new TodoPage.Todo("yell at staff", "maybe fire someone", false),
			new TodoPage.Todo("say no to drugs", "unless it's a drinking day", false),
			new TodoPage.Todo("listen to some tunes", "https://youtu.be/kTmZnQOfAF8", true)
		};
		list.AddRange(collection);
	}
	List<TodoPage.Todo> list2 = new List<TodoPage.Todo>();
	foreach (TodoPage.Todo todo in list)
	{
		if (!todo.Done)
		{
			list2.Add(todo);
		}
	}
	this.mylist.ItemsSource = list2;
	App.Note = list2[0].Note;
}
```

Now, the _App.Note_ attribute is equal to "keep steaks for dinner".

```
private void IndexPage_CurrentPageChanged(object sender, EventArgs e)
{
	if (base.Children.IndexOf(base.CurrentPage) == 4)
	{
		using (ExifReader exifReader = new ExifReader(Path.Combine(Application.Current.DirectoryInfo.Resource, "gallery", "05.jpg")))
		{
			string desc;
			if (exifReader.GetTagValue<string>(ExifTags.ImageDescription, out desc))
			{
				App.Desc = desc;
			}
			return;
		}
	}
	App.Desc = "";
}
```

So now, we have to get to the fourth image, just to let the app read the description of the "05.jpg" image, which is "water".

Finally, it gets some word from the following API call:

```
App.Step = Application.Current.ApplicationInfo.Metadata["its"];
```

Which refers to the "tizen-manifest.xml" file. If we check it, we will see the last word:

```
<metadata key="its" value="magic" />
```

So now we have the following data:

```
byte[] bytes = Encoding.ASCII.GetBytes(App.Password + App.Note + App.Step + App.Desc);
	||
	\/
bytes [] = Encoding.ASCII.GetBytes("mullethatkeep steaks for dinnermagicwater");
```

We check that this string is equal to the SHA256 of:

```
50 148 76 233 110 199 228 72 114 227 78 138 93 189 189 147 159 70 66 223 123 137 44 73 101 235 129 16 181 139 104 56
	||
	\/
32944ce96ec7e44872e34e8a5dbdbd939f4642df7b892c4965eb8110b58b6838
```

We get the hash of the string:

```
$ echo -n "mullethatkeep steaks for dinnermagicwater" | shasum -a 256

32944ce96ec7e44872e34e8a5dbdbd939f4642df7b892c4965eb8110b58b6838  -
```

Great!

After that, it executes the function _GetImage_, which will take the previously obtained data, mix it, and hashed using SHA256 again to obtain a key that will be used to decrypt the _Resource.dll_ file, which is not a dll. This process will result in an image.

We have developed an script to get so.


n3ver_go1ng_to_recov3r@flare-on.com