import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException, InterruptedException, ClassNotFoundException {
        if(args.length != 2){
            System.err.println("GPA Calculator <Input-Path> <Output-Dir>");
            System.exit(2);
        }
        Configuration conf = new Configuration();
        FileSystem fs = FileSystem.get(conf);
        boolean exists = fs.exists(new Path(args[1]));
        if(exists) {
            fs.delete(new Path(args[1]), true);
        }
        Job job = Job.getInstance(conf, "GPA Calculator");
        job.setJarByClass(Main.class);
        job.setMapperClass(MapClass.class);
        job.setReducerClass(ReduceClass.class);
        job.setMapOutputKeyClass(Text.class);
        job.setMapOutputValueClass(ValuePair.class);
        job.setOutputKeyClass(Text.class);
        job.setOutputValueClass(FloatWritable.class);
        FileInputFormat.addInputPath(job, new Path(args[0]));
        FileOutputFormat.setOutputPath(job, new Path(args[1]));
        System.exit(job.waitForCompletion(true) ? 0 : 1);
    }
}



import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
public class MapClass extends Mapper<Object, Text, Text, ValuePair>{
    private final Text studentName = new Text();
    @Override
    protected void map(Object key, Text value, Context context) throws IOException, InterruptedException {
        StringTokenizer record = new StringTokenizer(value.toString());
        List<String> infoList = new ArrayList<>();
        while (record.hasMoreTokens()){
            infoList.add(record.nextToken());
        }
        studentName.set(infoList.get(0));
        context.write(studentName, new ValuePair(Float.parseFloat(infoList.get(infoList.size()-3)), Float.parseFloat(infoList.get(infoList.size()-1))));

    }
}



import org.apache.hadoop.io.FloatWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ReduceClass extends Reducer<Text, ValuePair, Text, FloatWritable> {
    private ValuePair theValue = new ValuePair();
    float first = 0;
    float second = 0;
    float sum = 0;
    float sumCredits = 0;
    float gpa = 0;
    private List<Float> credits = new ArrayList<>();
    private FloatWritable result = new FloatWritable();
    @Override
    protected void reduce(Text key, Iterable<ValuePair> values, Context context) throws IOException, InterruptedException {
        while (values.iterator().hasNext()){
            theValue = values.iterator().next();
            first = theValue.getHours();
            second = theValue.getScore();
            credits.add(first);
            sum += (first * second);
        }
        for(Float d : credits)
            sumCredits += d;
        gpa = sum / sumCredits;
        result.set(gpa);
        credits.clear();
        first = 0;
        second = 0;
        sum = 0;
        sumCredits = 0;
        gpa = 0;
        context.write(key, result);
    }
}
